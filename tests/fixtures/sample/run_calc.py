import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import calc  # noqa: E402

assert calc.add(1, 2) == 3
assert calc.sub(3, 1) == 2
print("sample ran")
