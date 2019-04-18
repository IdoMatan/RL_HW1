import numpy as np


class Language:
    def __init__(self, language_cell=['B', 'K', 'O', '-'], starting_letter_idx=1, word_length=5):
        self.languageCell = language_cell
        self.startingLetterIdx = starting_letter_idx
        self.endingLetterIdx = self.languageCell.__len__()

        self.pTransitionMat = np.array([[0.1, 0.325, 0.25, 0.325],
                                        [0.4, 0, 0.4, 0.2],
                                        [0.2, 0.2, 0.2, 0.4],
                                        [0, 0, 0, 0]])  # 0 probability to transtion out of definitions since we are only considering a single word then we want there to be no transition probability from the end of word letter '-' to any other letter

        self.K = word_length
        self.bestWord = "B"

        self.dynProgArrayWord = np.zeros((self.languageCell.__len__(), self.K))
        self.dynProgArrayCost = np.zeros((self.languageCell.__len__(), self.K + 1))

        self.dynProgArrayCost[3, self.K] = 1

    def find_best_word(self):
        # Dynamic Programming
        for kk in range(self.K, 0, -1):
            for jj in range(4):
                curProbabilityMat = np.multiply(self.pTransitionMat[jj], self.dynProgArrayCost[:, kk])
                self.dynProgArrayCost[jj, kk-1], self.dynProgArrayWord[jj, kk-1] = np.max(curProbabilityMat), np.argmax(curProbabilityMat)

        #  Reconstruct highest probability word
        curLetterIdx = np.argmax(self.dynProgArrayCost[:, kk-1])  # index of the of word firs letter
        for kk in range(self.K):
            curLetterIdx = self.dynProgArrayWord[int(curLetterIdx), kk]
            self.bestWord += self.languageCell[int(curLetterIdx)]


def main():
    language = Language()

    language.find_best_word()

    print(language.bestWord)


main()

