"""
NumPy Code Examples - Basic Concepts and Operations
"""

import numpy as np

# 1. Creating Arrays
print("=== Creating Arrays ===")
# From lists
arr1 = np.array([1, 2, 3, 4, 5])
print(f"1D Array: {arr1}")

# 2D array
arr2d = np.array([[1, 2, 3], [4, 5, 6]])
print(f"2D Array:\n{arr2d}")

# Using built-in functions
zeros = np.zeros(5)
ones = np.ones((3, 3))
range_arr = np.arange(0, 10, 2)
linspace_arr = np.linspace(0, 1, 5)

print(f"Zeros: {zeros}")
print(f"Ones:\n{ones}")
print(f"Range: {range_arr}")
print(f"Linspace: {linspace_arr}")

# 2. Array Properties
print("\n=== Array Properties ===")
arr = np.array([[1, 2, 3], [4, 5, 6]])
print(f"Shape: {arr.shape}")
print(f"Size: {arr.size}")
print(f"Data type: {arr.dtype}")
print(f"Dimensions: {arr.ndim}")

# 3. Array Operations
print("\n=== Array Operations ===")
a = np.array([1, 2, 3])
b = np.array([4, 5, 6])

# Element-wise operations
print(f"Addition: {a + b}")
print(f"Multiplication: {a * b}")
print(f"Power: {a ** 2}")

# Broadcasting
scalar = 5
print(f"Array + Scalar: {a + scalar}")

# 4. Mathematical Functions
print("\n=== Mathematical Functions ===")
arr = np.array([1, 4, 9, 16, 25])
print(f"Square root: {np.sqrt(arr)}")
print(f"Exponential: {np.exp([1, 2, 3])}")
print(f"Logarithm: {np.log([1, 10, 100])}")
print(f"Sine: {np.sin([0, np.pi/2, np.pi])}")

# 5. Array Manipulation
print("\n=== Array Manipulation ===")
arr = np.array([[1, 2, 3], [4, 5, 6]])

# Reshaping
reshaped = arr.reshape(3, 2)
print(f"Reshaped:\n{reshaped}")

# Transposing
transposed = arr.T
print(f"Transposed:\n{transposed}")

# Flattening
flattened = arr.flatten()
print(f"Flattened: {flattened}")

# 6. Array Indexing and Slicing
print("\n=== Array Indexing and Slicing ===")
arr = np.array([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])

# Basic indexing
print(f"Element [1,2]: {arr[1, 2]}")
print(f"Row 1: {arr[1, :]}")
print(f"Column 2: {arr[:, 2]}")

# Boolean indexing
mask = arr > 5
print(f"Elements > 5: {arr[mask]}")

# 7. Statistical Operations
print("\n=== Statistical Operations ===")
arr = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])

print(f"Mean: {np.mean(arr)}")
print(f"Median: {np.median(arr)}")
print(f"Standard deviation: {np.std(arr)}")
print(f"Variance: {np.var(arr)}")
print(f"Min: {np.min(arr)}")
print(f"Max: {np.max(arr)}")

# Along axis
print(f"Mean along axis 0: {np.mean(arr, axis=0)}")
print(f"Mean along axis 1: {np.mean(arr, axis=1)}")

# 8. Linear Algebra
print("\n=== Linear Algebra ===")
# Matrix multiplication
a = np.array([[1, 2], [3, 4]])
b = np.array([[5, 6], [7, 8]])

dot_product = np.dot(a, b)
print(f"Matrix multiplication:\n{dot_product}")

# Determinant
det = np.linalg.det(a)
print(f"Determinant: {det}")

# Eigenvalues and eigenvectors
eigenvals, eigenvecs = np.linalg.eig(a)
print(f"Eigenvalues: {eigenvals}")
print(f"Eigenvectors:\n{eigenvecs}")

# 9. Random Numbers
print("\n=== Random Numbers ===")
# Set seed for reproducibility
np.random.seed(42)

# Random numbers
random_nums = np.random.random(5)
print(f"Random numbers: {random_nums}")

# Random integers
random_ints = np.random.randint(1, 10, size=(3, 3))
print(f"Random integers:\n{random_ints}")

# Normal distribution
normal_nums = np.random.normal(0, 1, 5)
print(f"Normal distribution: {normal_nums}")

# 10. Array Comparison and Logic
print("\n=== Array Comparison and Logic ===")
a = np.array([1, 2, 3, 4, 5])
b = np.array([3, 2, 1, 4, 5])

# Comparisons
print(f"Equal: {np.equal(a, b)}")
print(f"Greater: {np.greater(a, b)}")
print(f"Less: {np.less(a, b)}")

# Logical operations
print(f"AND: {np.logical_and(a > 2, b < 4)}")
print(f"OR: {np.logical_or(a > 3, b < 2)}")

# 11. Concatenation and Splitting
print("\n=== Concatenation and Splitting ===")
arr1 = np.array([[1, 2], [3, 4]])
arr2 = np.array([[5, 6], [7, 8]])

# Concatenation
concatenated = np.concatenate([arr1, arr2], axis=0)
print(f"Concatenated:\n{concatenated}")

# Vertical and horizontal stacking
vstacked = np.vstack([arr1, arr2])
hstacked = np.hstack([arr1, arr2])
print(f"V-stacked:\n{vstacked}")
print(f"H-stacked:\n{hstacked}")

# Splitting
split_arrs = np.split(concatenated, 2)
print(f"Split arrays: {len(split_arrs)} arrays")
