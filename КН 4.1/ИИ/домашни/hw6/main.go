package main

import (
	"bufio"
	"encoding/csv"
	"fmt"
	"io"
	"math"
	"math/rand"
	"os"
	"strings"
	"time"
)

const K = 10 // Min number of training examples.

var r *rand.Rand = rand.New(rand.NewSource(time.Now().UnixMilli()))

// Node represents a decision tree's node or leaf.
type Node struct {
	Attribute string
	Value     string
	Children  []*Node
	Class     string
}

type Sample struct {
	Attributes map[string]string
	Class      string
}

func parseCSV(filename string) ([]Sample, error) {
	file, err := os.Open(filename)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	reader := csv.NewReader(bufio.NewReader(file))
	var dataset []Sample

	for {
		record, err := reader.Read()
		if err == io.EOF {
			break
		}
		if err != nil {
			return nil, err
		}

		sample := Sample{
			Attributes: map[string]string{
				"age":         record[1],
				"menopause":   record[2],
				"tumor-size":  record[3],
				"inv-nodes":   record[4],
				"node-caps":   record[5],
				"deg-malig":   record[6],
				"breast":      record[7],
				"breast-quad": record[8],
				"irradiat":    record[9],
			},
			Class: record[0],
		}
		dataset = append(dataset, sample)
	}

	return dataset, nil
}

func entropy(samples []Sample) float64 {
	labelCounts := make(map[string]int)
	for _, sample := range samples {
		labelCounts[sample.Class]++
	}
	ent := 0.0
	for _, count := range labelCounts {
		probability := float64(count) / float64(len(samples))
		if probability > 0 {
			ent -= probability * math.Log2(probability)
		}
	}
	return ent
}

func splitDatasetOnAttribute(samples []Sample, attribute, value string) []Sample {
	var matches []Sample
	for _, sample := range samples {
		if sample.Attributes[attribute] == value {
			matches = append(matches, sample)
		}
	}
	return matches
}

func chooseBestAttributeToSplit(samples []Sample, attributes []string) (string, float64) {
	bestGain := 0.0
	bestAttribute := ""
	baseEntropy := entropy(samples)
	for _, attribute := range attributes {
		attributeEntropy := 0.0
		attributeValuesCount := make(map[string]int)
		for _, sample := range samples {
			attributeValuesCount[sample.Attributes[attribute]]++
		}
		for value, count := range attributeValuesCount {
			subset := splitDatasetOnAttribute(samples, attribute, value)
			probability := float64(count) / float64(len(samples))
			attributeEntropy += probability * entropy(subset)
		}
		informationGain := baseEntropy - attributeEntropy
		if informationGain > bestGain {
			bestGain = informationGain
			bestAttribute = attribute
		}
	}
	return bestAttribute, bestGain
}

func majorityVote(samples []Sample) string {
	labelCounts := make(map[string]int)
	for _, sample := range samples {
		labelCounts[sample.Class]++
	}
	majorityLabel := ""
	maxCount := 0
	for label, count := range labelCounts {
		if count > maxCount {
			maxCount = count
			majorityLabel = label
		}
	}
	return majorityLabel
}

func buildTree(samples []Sample, attributes []string) *Node {
	if len(samples) < K { // prevent overfitting
		return &Node{Class: majorityVote(samples)}
	}
	if len(samples) == 0 {
		panic("no samples to build a tree")
	}
	if len(attributes) == 0 {
		return &Node{Class: majorityVote(samples)}
	}

	defaultLabel := majorityVote(samples)
	bestAttribute, bestGain := chooseBestAttributeToSplit(samples, attributes)
	if bestGain == 0 {
		return &Node{Class: defaultLabel}
	}

	node := Node{Attribute: bestAttribute}

	uniqueValues := make(map[string]bool)
	for _, sample := range samples {
		uniqueValues[sample.Attributes[bestAttribute]] = true
	}

	newAttributes := make([]string, 0, len(attributes))
	for _, attribute := range attributes {
		if attribute != bestAttribute {
			newAttributes = append(newAttributes, attribute)
		}
	}

	for value := range uniqueValues {
		subset := splitDatasetOnAttribute(samples, bestAttribute, value)
		child := buildTree(subset, newAttributes)
		child.Value = value
		node.Children = append(node.Children, child)
	}
	return &node
}

func printTree(node *Node, level int) {
	if node == nil {
		return
	}
	prefix := strings.Repeat(" ", level*2)
	if node.Class != "" {
		fmt.Printf("%sLabel: %s\n", prefix, node.Class)
		return
	}
	fmt.Printf("%s%s = %s\n", prefix, node.Attribute, node.Value)
	for _, child := range node.Children {
		printTree(child, level+1)
	}
}

func classify(sample Sample, node *Node) string {
	if node.Class != "" {
		return node.Class
	}
	for _, child := range node.Children {
		if sample.Attributes[node.Attribute] == child.Value {
			return classify(sample, child)
		}
	}
	return "unknown"
}

func shuffleDataset(dataset []Sample) []Sample {
	r := rand.New(rand.NewSource(time.Now().Unix()))
	shuffled := make([]Sample, len(dataset))
	perm := r.Perm(len(dataset))
	for i, randIndex := range perm {
		shuffled[i] = dataset[randIndex]
	}
	return shuffled
}

func crossValidation(dataset []Sample, k int, attributes []string) ([]float64, float64) {
	foldSize := len(dataset) / k
	r.Shuffle(len(dataset), func(i, j int) { dataset[i], dataset[j] = dataset[j], dataset[i] })
	accuracies := make([]float64, k)

	for i := 0; i < k; i++ {
		begin := i * foldSize
		end := begin + foldSize
		if i == k-1 {
			end = len(dataset)
		}
		testSet := dataset[begin:end]
		trainSet := append(dataset[:begin], dataset[end:]...)

		tree := buildTree(trainSet, attributes)
		correct := 0
		for _, sample := range testSet {
			predictedLabel := classify(sample, tree)
			if predictedLabel == sample.Class {
				correct++
			}
		}
		accuracy := float64(correct) / float64(len(testSet))
		accuracies[i] = accuracy
	}
	sumAcc := 0.0
	for _, acc := range accuracies {
		sumAcc += acc
	}
	meanAcc := sumAcc / float64(k)
	return accuracies, meanAcc
}

func wait() {
	var cmd string
	for cmd != "exit" {
		fmt.Println("Type \"exit\" to exit")
		fmt.Scan(&cmd)
	}
}

func main() {
	const folds = 10
	attributes := []string{"age", "menopause", "tumor-size", "inv-nodes", "node-caps", "deg-malig", "breast", "breast-quad", "irradiat"}

	filename := "breast-cancer.data"
	samples, err := parseCSV(filename)
	if err != nil {
		fmt.Printf("Error parsing CSV: %s\n", err)
		return
	}

	accuracies, meanAccuracy := crossValidation(samples, folds, attributes)

	for i, acc := range accuracies {
		fmt.Printf("Accuracy for fold %d: %.2f%%\n", i+1, acc*100)
	}
	fmt.Printf("Mean Accuracy: %.2f%%\n", meanAccuracy*100)

	wait()
}
