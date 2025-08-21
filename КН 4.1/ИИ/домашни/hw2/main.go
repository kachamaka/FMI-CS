package main

import (
	"fmt"
	"math"
	"math/rand"
	"time"
)

type State struct {
	n            int
	queens       []int
	queensPerRow []int
	queensPerD1  []int
	queensPerD2  []int
	solved       bool

	rng *rand.Rand
}

func (s *State) generateRandomNum(rang int, passed map[int]bool) int {
	for {
		i := s.rng.Intn(rang)
		if pass, _ := passed[i]; !pass {
			passed[i] = true
			return i
		}
	}
}

func (s *State) Print() {
	queensRows := make([][]bool, s.n)

	for i := range queensRows {
		queensRows[i] = make([]bool, s.n)
	}

	for i, q := range s.queens {
		queensRows[q][i] = true
	}

	for _, row := range queensRows {
		for _, q := range row {
			if q {
				fmt.Print("*")
			} else {
				fmt.Print("_")
			}
		}
		fmt.Println()
	}
}

func (s *State) incrementRow(qCol int) {
	s.queensPerRow[s.queens[qCol]]++
}

func (s *State) incrementD1(qCol int) {
	s.queensPerD1[qCol+s.queens[qCol]]++
}

func (s *State) incrementD2(qCol int) {
	s.queensPerD2[s.n-qCol-1+s.queens[qCol]]++
}

func (s *State) decrementD1(qCol int) {
	s.queensPerD1[qCol+s.queens[qCol]]--
}

func (s *State) decrementRow(qCol int) {
	s.queensPerRow[s.queens[qCol]]--
}

func (s *State) decrementD2(qCol int) {
	s.queensPerD2[s.n-qCol-1+s.queens[qCol]]--
}

func (s *State) incrementQConflicts(qCol int) {
	s.incrementRow(qCol)
	s.incrementD1(qCol)
	s.incrementD2(qCol)
}

func (s *State) decrementQConflicts(qCol int) {
	s.decrementRow(qCol)
	s.decrementD1(qCol)
	s.decrementD2(qCol)
}

func (s *State) getConflicts(qCol, qRow int) int {
	return s.queensPerRow[qRow] + s.queensPerD1[qCol+qRow] + s.queensPerD2[s.n-qCol-1+qRow]
}

func (s *State) MaxMinConflicts() bool {
	maxQConflCol := s.maxConflictQueen()
	if maxQConflCol == -1 {
		s.solved = true
		return true
	}
	minQConflRow := s.minConflictRow(maxQConflCol)

	s.decrementQConflicts(maxQConflCol)

	s.queens[maxQConflCol] = minQConflRow

	s.incrementQConflicts(maxQConflCol)

	return false
}

func (s *State) minConflictRow(qCol int) int {
	minConflictRows := []int{}
	minConfl := math.MaxInt

	for row := 0; row < s.n; row++ {
		confl := s.getConflicts(qCol, row)

		if confl < minConfl {
			minConflictRows = []int{}
			minConflictRows = append(minConflictRows, row)
			minConfl = confl
		} else if confl == minConfl {
			minConflictRows = append(minConflictRows, row)
		}
	}

	return minConflictRows[s.rng.Intn(len(minConflictRows))]
}

func (s *State) maxConflictQueen() int {
	maxConflictQueens := []int{}
	maxConflict := -1

	for qCol := 0; qCol < s.n; qCol++ {
		qRow := s.queens[qCol]
		confl := s.getConflicts(qCol, qRow)
		if confl > maxConflict {
			maxConflictQueens = []int{}
			maxConflictQueens = append(maxConflictQueens, qCol)
			maxConflict = confl
		} else if confl == maxConflict {
			maxConflictQueens = append(maxConflictQueens, qCol)
		}
	}

	if maxConflict == 3 {
		// solved
		return -1
	}

	return maxConflictQueens[s.rng.Intn(len(maxConflictQueens))]
}

func NewRandomState(n int) *State {
	var s State
	s.rng = rand.New(rand.NewSource(time.Now().UnixNano()))
	s.n = n
	s.solved = false
	s.queens = make([]int, n)
	s.queensPerRow = make([]int, n)
	s.queensPerD1 = make([]int, 2*n-1)
	s.queensPerD2 = make([]int, 2*n-1)

	passed := make(map[int]bool)
	for i := 0; i < n; i++ {
		// generate row number for column i
		// one queen per column
		s.queens[i] = s.generateRandomNum(n, passed)
		s.incrementQConflicts(i)
	}

	return &s
}

func NewHorseState(n int) *State {
	var s State
	s.rng = rand.New(rand.NewSource(time.Now().UnixNano()))
	s.n = n
	s.solved = false
	s.queens = make([]int, n)
	s.queensPerRow = make([]int, n)
	s.queensPerD1 = make([]int, 2*n-1)
	s.queensPerD2 = make([]int, 2*n-1)

	col := 1
	for row := 0; row < n; row++ {
		s.queens[col] = row
		s.incrementQConflicts(col)
		col += 2
		if col >= n {
			col = 0
		}
	}

	return &s
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
	fmt.Print("N = ")
	fmt.Scan(&n)

	if n < 1 {
		fmt.Println("Incorrect n")
		wait()
		return
	} else if n == 1 {
		fmt.Println("Solved")
		wait()
		return
	} else if n <= 3 {
		fmt.Println("-1")
		wait()
		return
	}

	var s *State
	if n > 12000 {
		s = NewHorseState(n)
	} else {
		s = NewRandomState(n)
	}

	k := 3 * n
	start := time.Now()

	for !s.solved {
		iter := 0
		for iter < k {
			if s.MaxMinConflicts() {
				if n < 100 {
					s.Print()
				}
				elapsed := time.Since(start)
				fmt.Printf("SOLVED in %d iterations in %s\n", iter, elapsed)
				break
			}
			iter++
		}

		if !s.solved {
			fmt.Printf("Random restart at %d iterations\n", iter)
			s = NewRandomState(n)
		}
	}

	wait()
}
