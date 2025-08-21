package main

import (
	"fmt"
	"math"
)

const (
	Empty   = " "
	PlayerX = "X"
	PlayerO = "O"
)

type TicTacToe struct {
	board         [][]string
	currentPlayer string
}

func (t *TicTacToe) printBoard() {
	fmt.Println("  1 2 3")
	for i, row := range t.board {
		fmt.Printf("%d ", i+1)
		for _, cell := range row {
			fmt.Printf("%s ", cell)
		}
		fmt.Println()
	}
	fmt.Println()
}

func (t *TicTacToe) initializePlayer() {
	fmt.Print("Choose starting player (X or O): ")
	fmt.Scan(&t.currentPlayer)
	if t.currentPlayer != PlayerX && t.currentPlayer != PlayerO {
		fmt.Println("Invalid player. Defaulting to X.")
		t.currentPlayer = PlayerX
	}
}

func (t *TicTacToe) initializeBoard() {
	t.board = make([][]string, 3)
	for i := range t.board {
		t.board[i] = make([]string, 3)
		for j := range t.board[i] {
			t.board[i][j] = Empty
		}
	}
}

func (t *TicTacToe) playerMove() {
	var row, col int
	for {
		fmt.Print("Enter your move (row and column, e.g., 1 2): ")
		fmt.Scan(&row, &col)

		if t.isValidMove(row-1, col-1) {
			t.board[row-1][col-1] = PlayerX
			break
		} else {
			fmt.Println("Invalid move. Try again.")
		}
	}
}

func (t *TicTacToe) isValidMove(row, col int) bool {
	if row < 0 || row >= 3 || col < 0 || col >= 3 || t.board[row][col] != Empty {
		return false
	}
	return true
}

func (t *TicTacToe) switchPlayer() {
	if t.currentPlayer == PlayerX {
		t.currentPlayer = PlayerO
	} else {
		t.currentPlayer = PlayerX
	}
}

func (t *TicTacToe) computerMove() {
	_, move := minimax(t.board, 0, t.currentPlayer, math.Inf(-1), math.Inf(1))
	t.board[move[0]][move[1]] = PlayerO
}

func getWinner(board [][]string) string {
	for _, row := range board {
		if row[0] == row[1] && row[1] == row[2] && row[0] != Empty {
			return row[0]
		}
	}

	for i := 0; i < 3; i++ {
		if board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i] != Empty {
			return board[0][i]
		}
	}

	if board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != Empty {
		return board[0][0]
	}
	if board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != Empty {
		return board[0][2]
	}

	return Empty
}

func evaluate(board [][]string, depth int) float64 {
	winner := getWinner(board)
	switch winner {
	case PlayerO:
		return 10.0 - float64(depth)
	case PlayerX:
		return float64(depth) - 10.0
	default:
		return 0.0
	}
}

func isBoardFull(board [][]string) bool {
	for _, row := range board {
		for _, cell := range row {
			if cell == Empty {
				return false
			}
		}
	}
	return true
}

func isGameOver(board [][]string) bool {
	return getWinner(board) != Empty || isBoardFull(board)
}

func minimax(board [][]string, depth int, maximizingPlayer string, alpha, beta float64) (float64, [2]int) {
	if isGameOver(board) {
		score := evaluate(board, depth)
		return score, [2]int{-1, -1}
	}

	var bestMove [2]int
	if maximizingPlayer == PlayerO {
		maxEval := math.Inf(-1)

		for i := 0; i < 3; i++ {
			for j := 0; j < 3; j++ {
				if board[i][j] == Empty {
					board[i][j] = PlayerO
					eval, _ := minimax(board, depth+1, PlayerX, alpha, beta)
					board[i][j] = Empty

					if eval > maxEval {
						maxEval = eval
						bestMove = [2]int{i, j}
					}

					alpha = math.Max(alpha, eval)
					if beta <= alpha {
						break
					}
				}
			}
		}

		return maxEval, bestMove
	} else {
		minEval := math.Inf(1)

		for i := 0; i < 3; i++ {
			for j := 0; j < 3; j++ {
				if board[i][j] == Empty {
					board[i][j] = PlayerX
					eval, _ := minimax(board, depth+1, PlayerO, alpha, beta)
					board[i][j] = Empty

					if eval < minEval {
						minEval = eval
						bestMove = [2]int{i, j}
					}

					beta = math.Min(beta, eval)
					if beta <= alpha {
						break
					}
				}
			}
		}

		return minEval, bestMove
	}
}

func (t *TicTacToe) Start() {
	t.initializePlayer()
	t.initializeBoard()

	for {
		t.printBoard()

		if t.currentPlayer == PlayerX {
			t.playerMove()
		} else {
			t.computerMove()
		}

		if isGameOver(t.board) {
			break
		}

		t.switchPlayer()
	}

	t.printBoard()
	winner := getWinner(t.board)
	if winner == Empty {
		fmt.Println("Draw.")
	} else {
		fmt.Printf("Game over. %s wins!\n", winner)
	}

	wait()
}

func wait() {
	var cmd string
	for cmd != "exit" {
		fmt.Println("Type \"exit\" to exit")
		fmt.Scan(&cmd)
	}
}

func main() {
	t := TicTacToe{}
	t.Start()
}
