import math
import random
import matplotlib.pyplot as plt
import colorsys

FILES = ["./normal.txt", "./unbalance.txt"]
SPLITTER = ['\t', ' ']
RESTARTS = 30

def distance(point: tuple, center: tuple):
    return math.sqrt((point[0]-center[0])**2+(point[1]-center[1])**2)

def meanPointOfPoints(points: list[tuple]):
    x = sum([x[0] for x in points])/len(points)
    y = sum([x[1] for x in points])/len(points)

    return (x,y)

def generateCentroids(k: int, data: list[tuple]):
    centroids = []
    chosenIndexes = []
    for i in range(k):
        randomIndex = random.randint(0, len(data) - 1)
        while randomIndex in chosenIndexes:
            randomIndex = random.randint(0, len(data) - 1)
        chosenIndexes.append(randomIndex)

        chosenPoint = data[randomIndex]
        centroids.append(chosenPoint)

    return centroids

def drawClusters(clusters, centroids):
    clusterIndex = 0
    plt.rcParams['figure.facecolor'] = 'gray'
    _, ax = plt.subplots()
    for cluster in clusters:
        hsv = (math.fmod(clusterIndex * 0.618033988749895, 1.0), 0.5, math.sqrt(1.0 - math.fmod(clusterIndex * 0.618033988749895, 0.5)))
        ax.plot([x[0] for x in cluster], [x[1] for x in cluster], "o", markersize=2, color=colorsys.hsv_to_rgb(*hsv))
        ax.plot(centroids[clusterIndex][0], centroids[clusterIndex][1], "x", markersize=30, color=colorsys.hsv_to_rgb(*hsv))
        clusterIndex += 1
    plt.savefig("result.png", bbox_inches='tight')
    plt.show()

def calculateClusterSquaredDistancesSum(clusters, centroids):
    totalCSDS = 0
    for clusterIndex in range(len(clusters)):
        currentCSDS = 0
        for point in clusters[clusterIndex]:
            currentCSDS += distance(point, centroids[clusterIndex])
        totalCSDS += currentCSDS
    return totalCSDS

def kMeans(k: int, data: list[tuple]):
    minClusterSquaredDistancesSum = float('inf')
    bestClusters = []
    bestCentroids = []

    for restart in range(RESTARTS):
        centroids = generateCentroids(k, data)
        clusters = [[] for i in range(k)]
        changeCentroids = True

        iterations = 1
        while changeCentroids and iterations <= 100:
            changeCentroids = True
            clusters = [[] for i in range(k)]

            # assign point to cluster with min distance
            for point in data:
                minDistance = distance(point, centroids[0])
                minCentroid = 0
                for centroidIndex in range(1, len(centroids)):
                    currentDistance = distance(point, centroids[centroidIndex])
                    if currentDistance < minDistance:
                        minDistance = currentDistance
                        minCentroid = centroidIndex
                clusters[minCentroid].append(point)

            # check for all clusters if mean will change centroid point
            for clusterIndex in range(len(clusters)):
                if clusters[clusterIndex] != []:
                    currentClusterMean = meanPointOfPoints(clusters[clusterIndex])
                    changeCentroids = currentClusterMean[0] != centroids[clusterIndex][0] or currentClusterMean[1] != centroids[clusterIndex][1]
                    centroids[clusterIndex] = currentClusterMean

            iterations += 1

        drawClusters(clusters, centroids)

        clusterSquaredDistancesSum = calculateClusterSquaredDistancesSum(clusters, centroids)
        print("Temp cluster squared distances sum =", clusterSquaredDistancesSum)

        if clusterSquaredDistancesSum < minClusterSquaredDistancesSum:
            minClusterSquaredDistancesSum = clusterSquaredDistancesSum
            bestClusters = clusters
            bestCentroids = centroids 
        
    return (bestClusters, bestCentroids)
    

if __name__ == "__main__":
    print("Choose a dataset:")
    print("1. normal.txt")
    print("2. unbalance.txt")
    
    choice = int(input("Enter the option (1 or 2): "))
    index = choice-1
    k = int(input("Enter the number of clusters (k): "))

    file = open(FILES[index], "r").readlines()
    data = [*map(lambda x: tuple([float(i) for i in x[:-1].split(SPLITTER[index])]), file)]

    clusters, centroids = kMeans(k, data)
    drawClusters(clusters, centroids)
    print("Best cluster squared distances sum =", calculateClusterSquaredDistancesSum(clusters, centroids))