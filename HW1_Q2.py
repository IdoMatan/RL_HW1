import numpy as np


class Language:
    def __init__(self, language_cell=['B', 'K', 'O', '-'], starting_letter_idx=1, word_length=10):
        self.languageCell = language_cell
        self.startingLetterIdx = starting_letter_idx
        self.endingLetterIdx = self.languageCell.__len__()

        self.pTransitionMat = np.array([[0.1, 0.325, 0.25, 0.325],
                                        [0.4, 0, 0.4, 0.2],
                                        [0.2, 0.2, 0.2, 0.4],
                                        [0, 0, 0, 0]])  # 0 probability to transtion out of definitions since we are only considering a single word then we want there to be no transition probability from the end of word letter '-' to any other letter

        self.K = word_length
        self.bestWord = "x" * self.K

        self.dynProgArrayWord = np.zeros((self.languageCell.__len__(), self.K + 1))
        self.dynProgArrayCost = np.zeros((self.languageCell.__len__(), self.K + 1))

        # self.dynProgArrayCost = np.ones((self.startingLetterIdx, 1))
        # self.dynProgArrayCost[self.startingLetterIdx, 0] = 1
        self.dynProgArrayCost[:, 0] = np.ones((1, self.languageCell.__len__()))

    # @staticmethod
    def find_best_word(self):
        # Dynamic Programming
        for kk in range(1, self.K + 1):
            curProbabilityMat = np.dot(self.pTransitionMat, self.dynProgArrayCost[:, kk-1])
            self.dynProgArrayCost[:, kk], self.dynProgArrayWord[:, kk] = np.max(curProbabilityMat)

#  Reconstruct highest probability word
        curLetterIdx = self.endingLetterIdx  # index of the of word letter
        for kk in range((self.K + 1), 2, -1):
            curLetterIdx = Language.dynProgArrayWord[curLetterIdx, kk]
            self.bestWord[kk - 1] = self.languageCell[curLetterIdx]


def main():
    language = Language()

    language.find_best_word()

    print(language.bestWord)


main()


