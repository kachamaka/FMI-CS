package main

import (
	"fmt"
	"math"
	"math/rand"
	"time"
)

const (
	_epochs       = 10000
	_inputSize    = 2
	_hiddenSize   = 4
	_outputSize   = 1
	_learningRate = 1
)

var r *rand.Rand = rand.New(rand.NewSource(time.Now().UnixNano()))

// NeuralNetwork represents a simple feedforward neural network
type NeuralNetwork struct {
	inputSize    int
	hiddenSize   int
	outputSize   int
	weightsIH    [][]float64 // Weights from input to hidden layer
	weightsHO    []float64   // Weights from hidden to output layer
	learningRate float64
}

// NewNeuralNetwork creates a new NeuralNetwork with random initial weights
func NewNeuralNetwork(inputSize, hiddenSize, outputSize int, learningRate float64) *NeuralNetwork {
	// Initialize random weights
	weightsIH := make([][]float64, hiddenSize)
	for i := range weightsIH {
		weightsIH[i] = make([]float64, inputSize)
		for j := range weightsIH[i] {
			weightsIH[i][j] = r.Float64() // Random weight
		}
	}

	weightsHO := make([]float64, hiddenSize)
	for i := range weightsHO {
		weightsHO[i] = r.Float64() // Random weight
	}

	return &NeuralNetwork{
		inputSize:    inputSize,
		hiddenSize:   hiddenSize,
		outputSize:   outputSize,
		weightsIH:    weightsIH,
		weightsHO:    weightsHO,
		learningRate: learningRate,
	}
}

// sigmoid activation function
func sigmoid(x float64) float64 {
	return 1.0 / (1.0 + math.Exp(-x))
}

// derivative of the sigmoid function
func sigmoidDerivative(x float64) float64 {
	return x * (1.0 - x)
}

// Train trains the neural network using backpropagation
func (nn *NeuralNetwork) Train(inputs [][]float64, targets []float64, epochs int) {
	for epoch := 0; epoch < epochs; epoch++ {
		for i := range inputs {
			// Forward pass
			hiddenLayerOutput := make([]float64, nn.hiddenSize)
			for j := 0; j < nn.hiddenSize; j++ {
				sum := 0.0
				for k := 0; k < nn.inputSize; k++ {
					sum += inputs[i][k] * nn.weightsIH[j][k]
				}
				hiddenLayerOutput[j] = sigmoid(sum)
			}

			output := 0.0
			for j := 0; j < nn.hiddenSize; j++ {
				output += hiddenLayerOutput[j] * nn.weightsHO[j]
			}
			output = sigmoid(output)

			// Backward pass
			outputError := targets[i] - output
			outputDelta := outputError * sigmoidDerivative(output)

			for j := 0; j < nn.hiddenSize; j++ {
				nn.weightsHO[j] += nn.learningRate * outputDelta * hiddenLayerOutput[j]
			}

			for j := 0; j < nn.hiddenSize; j++ {
				for k := 0; k < nn.inputSize; k++ {
					hiddenDelta := outputDelta * nn.weightsHO[j] * sigmoidDerivative(hiddenLayerOutput[j])
					nn.weightsIH[j][k] += nn.learningRate * hiddenDelta * inputs[i][k]
				}
			}
		}
	}
}

func (nn *NeuralNetwork) Predict(input []float64) float64 {
	// Forward pass
	hiddenLayerOutput := make([]float64, nn.hiddenSize)
	for j := 0; j < nn.hiddenSize; j++ {
		sum := 0.0
		for k := 0; k < nn.inputSize; k++ {
			sum += input[k] * nn.weightsIH[j][k]
		}
		hiddenLayerOutput[j] = sigmoid(sum)
	}

	output := 0.0
	for j := 0; j < nn.hiddenSize; j++ {
		output += hiddenLayerOutput[j] * nn.weightsHO[j]
	}
	return sigmoid(output)
}

func AND() {
	fmt.Println("Solving for AND")

	inputs := [][]float64{
		{0, 0},
		{0, 1},
		{1, 0},
		{1, 1},
	}

	targets := []float64{0, 0, 0, 1}

	nn := NewNeuralNetwork(_inputSize, _hiddenSize, _outputSize, _learningRate)

	nn.Train(inputs, targets, _epochs)

	for i, input := range inputs {
		prediction := nn.Predict(input)
		fmt.Printf("Input: %v, Target: %v, Prediction: %v\n", input, targets[i], prediction)
	}
	fmt.Println("------------------------------")
}

func OR() {
	fmt.Println("Solving for OR")
	inputs := [][]float64{
		{0, 0},
		{0, 1},
		{1, 0},
		{1, 1},
	}

	targets := []float64{0, 1, 1, 1}

	nn := NewNeuralNetwork(_inputSize, _hiddenSize, _outputSize, _learningRate)

	nn.Train(inputs, targets, _epochs)

	for i, input := range inputs {
		prediction := nn.Predict(input)
		fmt.Printf("Input: %v, Target: %v, Prediction: %v\n", input, targets[i], prediction)
	}
	fmt.Println("------------------------------")
}

func XOR() {
	fmt.Println("Solving for XOR")
	// Example for solving the XOR problem
	inputs := [][]float64{
		{0, 0},
		{0, 1},
		{1, 0},
		{1, 1},
	}

	targets := []float64{0, 1, 1, 0}

	// Create a neural network
	nn := NewNeuralNetwork(_inputSize, _hiddenSize, _outputSize, _learningRate)

	// Train the neural network
	nn.Train(inputs, targets, _epochs)

	// Test the trained neural network
	for i, input := range inputs {
		prediction := nn.Predict(input)
		fmt.Printf("Input: %v, Target: %v, Prediction: %v\n", input, targets[i], prediction)
	}
	fmt.Println("------------------------------")
}

func wait() {
	var cmd string
	for cmd != "exit" {
		fmt.Println("Type \"exit\" to exit")
		fmt.Scan(&cmd)
	}
}

func main() {
	fmt.Printf("Epochs: %d\nInput size: %d\nHidden size: %d\nOutput size: %d\nLearning rate: %.1f\n\n", _epochs, _inputSize, _hiddenSize, _outputSize, _learningRate)
	AND()

	OR()

	XOR()

	// wait()
}
