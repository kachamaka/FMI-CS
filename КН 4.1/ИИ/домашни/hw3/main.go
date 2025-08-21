package main

import (
	"fmt"
	"math"
	"math/rand"
	"sort"
	"time"
)

var r = rand.New(rand.NewSource(time.Now().UnixNano()))

const MAX_COORDS_VALUE = float64(600)
const GENERATIONS = 300000

func permutePath(src []int) []int {
	res := make([]int, len(src))
	copy(res, src)
	r.Shuffle(len(src), func(i, j int) {
		res[i], res[j] = res[j], res[i]
	})
	return res
}

type GA struct {
	input      []string
	dist       [][]float64
	population [][]int
	indices    []int

	bestPath    []int
	bestFitness float64

	generation            int
	populationCardinality int
	selectionCardinality  int
}

func (g *GA) initPopulation() {
	g.indices = make([]int, len(g.dist)-1)
	for i := 1; i < len(g.dist); i++ {
		g.indices[i-1] = i
	}

	for i := 0; i < g.populationCardinality; i++ {
		newIndividual := permutePath(g.indices)
		fitness := g.calcFitnessByIndividual(newIndividual)
		if fitness < g.bestFitness {
			g.bestFitness = fitness
			g.bestPath = newIndividual
		}
		g.population = append(g.population, newIndividual)
	}
}

func (g *GA) iterateGenerations(generations int) {
	for g.generation < generations {
		g.nextGeneration()
		if g.generation%500 == 0 || g.generation == 1 || g.generation == generations-1 {
			fmt.Println(g.bestPath, g.bestFitness, "BEST UNTIL GEN", g.generation)
			r = rand.New(rand.NewSource(time.Now().UnixNano()))
		}
		g.generation++
	}
	g.printPath()
}

func (g *GA) printPath() {
	if len(g.input) <= 0 {
		return
	}

	fmt.Print(g.input[0], " ")
	for i := 0; i < len(g.bestPath); i++ {
		fmt.Print(g.input[g.bestPath[i]], " ")
	}
	fmt.Print("\n")
}

func (g *GA) nextGeneration() {
	// r = rand.New(rand.NewSource(time.Now().UnixNano()))

	children := [][]int{}
	for len(children) < g.populationCardinality {
		child1, child2 := g.generateChildren()
		fitness1, fitness2 := g.calcFitnessByIndividual(child1), g.calcFitnessByIndividual(child2)
		if fitness1 < g.bestFitness {
			if fitness1 < fitness2 {
				g.bestFitness = fitness1
				g.bestPath = child1
			}
		}
		if fitness2 < g.bestFitness {
			if fitness2 < fitness1 {
				g.bestFitness = fitness2
				g.bestPath = child2
			}
		}
		children = append(children, child1)
		children = append(children, child2)
	}

	g.population = children
}

func (g *GA) generateChildren() ([]int, []int) {
	sampleParentsIndices := g.selectSampleParentsIndices()
	fitness := g.calcFitnessByIndices(sampleParentsIndices)
	parent1FitnessIdx := -1
	parent2FitnessIdx := -1
	for i := range fitness {
		if parent1FitnessIdx < 0 {
			parent1FitnessIdx = i
			continue
		}
		if parent2FitnessIdx < 0 {
			parent2FitnessIdx = i
			continue
		}
		potentialParent := i
		parent1FitnessIdx, parent2FitnessIdx = selectBestParents(
			[]int{parent1FitnessIdx, parent2FitnessIdx, potentialParent},
			[]float64{fitness[parent1FitnessIdx], fitness[parent2FitnessIdx], fitness[potentialParent]},
		)
	}

	child1, child2 := g.twoPointCrossover(g.population[sampleParentsIndices[parent1FitnessIdx]], g.population[sampleParentsIndices[parent2FitnessIdx]])

	return g.mutateChild(child1), g.mutateChild(child2)
}

func (g *GA) mutateChild(child []int) []int {
	idx1 := r.Intn(len(child))
	idx2 := r.Intn(len(child))
	child[idx1], child[idx2] = child[idx2], child[idx1]
	return child
}

func (g *GA) twoPointCrossover(parent1, parent2 []int) ([]int, []int) {
	child1 := make([]int, len(parent1), len(parent1))
	child2 := make([]int, len(parent2), len(parent2))

	point1 := r.Intn(len(parent1) - 1)
	point2 := point1
	for point2 == point1 {
		point2 = r.Intn(len(parent2) - 1)
	}

	if point1 > point2 {
		point1, point2 = point2, point1
	}

	seenChild1 := make(map[int]bool)
	seenChild2 := make(map[int]bool)
	for i := point1; i <= point2; i++ {
		child1[i] = parent1[i]
		seenChild1[parent1[i]] = true
	}
	for i := 0; i < point1; i++ {
		child2[i] = parent2[i]
		seenChild2[parent2[i]] = true
	}
	for i := point2 + 1; i < len(parent2); i++ {
		child2[i] = parent2[i]
		seenChild2[parent2[i]] = true
	}

	// fmt.Println(child1, child2, "?")
	// fmt.Println(seenChild1, "-", seenChild2, "?")

	ch1EmptyIndices := []int{}
	ch1Missing := []int{}
	ch2EmptyIndices := []int{}
	ch2Missing := []int{}
	for i := 0; i < len(child1); i++ {
		if child1[i] == 0 {
			ch1EmptyIndices = append(ch1EmptyIndices, i)
		}
		if !seenChild1[parent1[i]] {
			ch1Missing = append(ch1Missing, parent1[i])
		}
		if child2[i] == 0 {
			ch2EmptyIndices = append(ch2EmptyIndices, i)
		}
		if !seenChild2[parent2[i]] {
			ch2Missing = append(ch2Missing, parent2[i])
		}
	}

	for len(ch1EmptyIndices) > 0 || len(ch2EmptyIndices) > 0 {
		// fmt.Println(ch1EmptyIndices, ch2EmptyIndices)
		// fmt.Println(ch1Missing, ch2Missing)
		// fmt.Println("-----------")

		if len(ch1EmptyIndices) > 0 {

			idx := r.Intn(len(ch1EmptyIndices))
			val := r.Intn(len(ch1EmptyIndices))

			child1[ch1EmptyIndices[idx]] = ch1Missing[val]
			ch1EmptyIndices = append(ch1EmptyIndices[:idx], ch1EmptyIndices[idx+1:]...)
			ch1Missing = append(ch1Missing[:val], ch1Missing[val+1:]...)
		}

		if len(ch2EmptyIndices) > 0 {
			idx := r.Intn(len(ch2EmptyIndices))
			val := r.Intn(len(ch2EmptyIndices))

			child2[ch2EmptyIndices[idx]] = ch2Missing[val]
			ch2EmptyIndices = append(ch2EmptyIndices[:idx], ch2EmptyIndices[idx+1:]...)
			ch2Missing = append(ch2Missing[:val], ch2Missing[val+1:]...)
		}
	}

	return child1, child2
}

func selectBestParents(parents []int, fitness []float64) (int, int) {
	if fitness[0] > fitness[1] && fitness[0] > fitness[2] {
		return parents[1], parents[2]
	} else if fitness[1] > fitness[0] && fitness[1] > fitness[2] {
		return parents[0], parents[2]
	} else {
		return parents[0], parents[1]
	}
}

func (g *GA) selectSampleParentsIndices() []int {
	sampleParentsIndices := []int{}
	passed := make(map[int]bool)
	for len(sampleParentsIndices) < g.selectionCardinality {
		randomParentIndex := r.Intn(len(g.population))
		if !passed[randomParentIndex] {
			passed[randomParentIndex] = true
			sampleParentsIndices = append(sampleParentsIndices, randomParentIndex)
		} else {
			continue
		}
	}

	return sampleParentsIndices
}

func (g *GA) calcFitnessByIndividual(srcPath []int) float64 {
	return g.calcPathDistance(srcPath)
}

func (g *GA) calcFitnessByIndices(srcIndices []int) []float64 {
	fitness := make([]float64, len(srcIndices))
	for _, index := range srcIndices {
		fitness = append(fitness, g.calcPathDistance(g.population[index]))
	}
	return fitness
}

func (g *GA) calcPathDistance(path []int) float64 {
	d := float64(0)
	prev := 0
	for _, i := range path {
		d += g.dist[prev][i]
		prev = i
	}
	// d += g.dist[prev][0]
	return d
}

func leastTwo(n1, n2, n3 int) (int, int) {
	ints := []int{n1, n2, n3}
	sort.Ints(ints)
	return ints[0], ints[1]
}

func calcDistances(n int, coords [][]float64) [][]float64 {
	dist := make([][]float64, n)
	for i := range dist {
		dist[i] = make([]float64, n)
	}

	for i := range dist {
		for j := range dist[i] {
			xi := coords[i][0]
			yi := coords[i][1]
			xj := coords[j][0]
			yj := coords[j][1]
			d := math.Sqrt((xi-xj)*(xi-xj) + (yi-yj)*(yi-yj))
			dist[i][j] = d
			dist[j][i] = d
		}
	}

	return dist
}

func wait() {
	var cmd string
	for cmd != "exit" {
		fmt.Println("Type \"exit\" to exit")
		fmt.Scan(&cmd)
	}
}

func main() {
	var n int
	fmt.Scan(&n)
	if (n > 100 || n < 3) && n != 0 {
		fmt.Println("N should be between 3 and 100")
		return
	}

	if n == 0 {
		n := 12
		towns := []string{
			"Aberystwyth",
			"Brighton",
			"Edinburgh",
			"Exeter",
			"Glasgow",
			"Inverness",
			"Liverpool",
			"London",
			"Newcastle",
			"Nottingham",
			"Oxford",
			"Stratford",
		}

		coords := [][]float64{
			{0.190032e-03, -0.285946e-03},
			{383.458, -0.608756e-03},
			{-27.0206, -282.758},
			{335.751, -269.577},
			{69.4331, -246.780},
			{168.521, 31.4012},
			{320.350, -160.900},
			{179.933, -318.031},
			{492.671, -131.563},
			{112.198, -110.561},
			{306.320, -108.090},
			{217.343, -447.089},
		}

		g := GA{
			input:                 towns,
			dist:                  calcDistances(n, coords),
			populationCardinality: 100,
			selectionCardinality:  10,
			generation:            1,
			bestFitness:           math.MaxFloat64,
		}
		g.initPopulation()
		g.iterateGenerations(GENERATIONS)
	} else {
		coords := [][]float64{}
		for i := 0; i < n; i++ {
			x := -MAX_COORDS_VALUE + r.Float64()*(2*MAX_COORDS_VALUE)
			y := -MAX_COORDS_VALUE + r.Float64()*(2*MAX_COORDS_VALUE)
			coords = append(coords, []float64{x, y})
		}

		g := GA{
			dist:                  calcDistances(n, coords),
			populationCardinality: 100,
			selectionCardinality:  10,
			generation:            1,
			bestFitness:           math.MaxFloat64,
		}
		g.initPopulation()
		g.iterateGenerations(GENERATIONS)
	}

	wait()
}
