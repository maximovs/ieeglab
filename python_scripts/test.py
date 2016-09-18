import scipy.io
import sys
matrix = sys.argv[1]
print matrix
mat = scipy.io.loadmat(matrix)
eeg = mat['eeg_data']
eeg = eeg*3
scipy.io.savemat(matrix, {'eeg_data': eeg})