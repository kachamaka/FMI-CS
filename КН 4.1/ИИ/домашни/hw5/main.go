package main

import (
	"encoding/csv"
	"fmt"
	"log"
	"math"
	"math/rand"
	"os"
	"strings"
	"time"
)

var r = rand.New(rand.NewSource(time.Now().UnixNano()))

type NaiveBayesClassifier struct {
	ClassCounts     map[string]int
	AttributeCounts map[string]map[string]int
}

func (nb *NaiveBayesClassifier) GetAttribute(num int, attr string) string {
	return fmt.Sprintf("%d:%s", num, attr)
}

func (nb *NaiveBayesClassifier) Train(data [][]string) {
	nb.ClassCounts = make(map[string]int)
	nb.AttributeCounts = make(map[string]map[string]int)

	for _, row := range data {
		class := row[0]
		if _, ok := nb.ClassCounts[class]; !ok {
			nb.ClassCounts[class] = 0
			nb.AttributeCounts[class] = make(map[string]int)
		}
		attributes := row[1:]
		nb.ClassCounts[class]++
		for i := 0; i < len(attributes); i++ {
			attribute := nb.GetAttribute(i, attributes[i])
			if _, ok := nb.AttributeCounts[class][attribute]; !ok {
				nb.AttributeCounts[class][attribute] = 0
			}

			nb.AttributeCounts[class][attribute]++
		}
	}
}

func (nb *NaiveBayesClassifier) Predict(attributes []string) string {
	maxProbability := math.Inf(-1)
	predictedClass := ""

	for class := range nb.ClassCounts {
		probability := math.Log(float64(nb.ClassCounts[class]) / float64(len(attributes)))

		for i := 0; i < len(attributes); i++ {
			attribute := nb.GetAttribute(i, attributes[i])
			attributeCount := nb.AttributeCounts[class][attribute]
			// Ensure that there is no 0 in Log
			probability += math.Log(float64(attributeCount+1) / float64(nb.ClassCounts[class]+2))
		}

		if probability > maxProbability {
			maxProbability = probability
			predictedClass = class
		}
	}

	return predictedClass
}

// CrossValidation performs 10-fold cross-validation.
func CrossValidation(data [][]string) float64 {
	batchSize := len(data) / 10
	accuracySum := float64(0)

	for i := 0; i < 10; i++ {
		// Split data into training and testing sets
		testingStart := i * batchSize
		testingEnd := (i + 1) * batchSize
		testingSet := data[testingStart:testingEnd]
		trainingSet := append(data[:testingStart], data[testingEnd:]...)

		// Train the classifier
		classifier := NaiveBayesClassifier{}
		classifier.Train(trainingSet)

		// Test the classifier
		correct := 0
		for _, instance := range testingSet {
			actualClass := instance[0]
			attributes := instance[1:]
			predictedClass := classifier.Predict(attributes)

			if predictedClass == actualClass {
				correct++
			}
		}

		// Calculate accuracy for the batch
		accuracy := float64(correct) / float64(len(testingSet))
		fmt.Printf("Batch %d Accuracy: %.2f%%\n", i+1, accuracy*100)
		accuracySum += accuracy
	}

	return accuracySum / 10
}

func wait() {
	var cmd string
	for cmd != "exit" {
		fmt.Println("Type \"exit\" to exit")
		fmt.Scan(&cmd)
	}
}

func main() {
	file, err := os.Open("house-votes-84.data")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	reader := csv.NewReader(file)
	data, err := reader.ReadAll()
	if err != nil {
		log.Fatal(err)
	}

	r.Shuffle(len(data), func(i, j int) { data[i], data[j] = data[j], data[i] })

	// Convert string values to lowercase for consistency
	for _, row := range data {
		for i := range row {
			row[i] = strings.ToLower(strings.TrimSpace(row[i]))
		}
	}

	// Perform 10-fold cross-validation
	averageAccuracy := CrossValidation(data)

	fmt.Printf("Overall Average Accuracy: %.2f%%\n", averageAccuracy*100)

	wait()
}
