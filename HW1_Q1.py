import numpy as np


class Counting:
    def __init__(self, x, n):
        self.Dy_Phi = np.zeros((x, n))

    def phi(self, x, n):
        phi = 0
        if self.Dy_Phi[x-1, n-1] == 0 and x >= n:
            if x == n or n == 1:
                self.Dy_Phi[x - 1, n - 1] = 1
            else:
                for i in range(1, x):
                    phi += self.phi(i, n-1)

                self.Dy_Phi[x-1, n-1] = phi

        return self.Dy_Phi[x-1, n-1]


def main():
    X, N = 800, 12

    count = Counting(X, N)

    count.phi(X, N)

    print(count.Dy_Phi[X-1, N-1])


main()

