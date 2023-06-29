import math
import re

class Vector:
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z

    def __add__(self, other):
        return Vector(self.x + other.x, self.y + other.y, self.z + other.z)

    def __sub__(self, other):
        return Vector(self.x - other.x, self.y - other.y, self.z - other.z)

    def __truediv__(self, n):
        if n != 0:
            return Vector(self.x / n, self.y / n, self.z / n)
        else:
            raise ZeroDivisionError("Cannot divide Vector by zero")

    def __mul__(self, n):
        return Vector(self.x * n, self.y * n, self.z * n)

    def magnitude(self):
        return math.sqrt(self.x ** 2 + self.y ** 2 + self.z ** 2)

    def normalized(self):
        mag = self.magnitude()
        if mag != 0:
            return Vector(self.x / mag, self.y / mag, self.z / mag)
        else:
            raise ZeroDivisionError("Cannot normalize zero-length vector")
    
    def distance_to(self, other):
        diff = self - other  # Vetor diferença entre self e other
        return diff.magnitude()  # Magnitude do vetor diferença


def StringToVector(value)->Vector:
    matches = re.findall(r'[-+]?\d*\.\d+|\d+', value)

    x, y, z = map(float, matches)
    v=Vector(x,y,z)
    return v