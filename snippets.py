#!/usr/bin/env python
import sys
sys.path.insert(0, "./modules")

def uniq(arr, func):
    result = []
    identifiers = []
    for item in arr:
        x = func(item)
        if x not in identifiers:
            identifiers.append(x)
            result.append(item)
    return result

results = uniq(results, lambda r: r["name"].lower())
