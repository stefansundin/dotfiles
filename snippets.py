#!/usr/bin/env python
import sys
sys.path.insert(0, "./modules")

print(os.environ["HOME"])
print(json.dumps(response, indent=2))

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
