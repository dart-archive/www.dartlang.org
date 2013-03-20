var data = // ... initialize data ...

// property access is validated by tools
print(data.language);
print(data.targets[0]);
data.website.foreach((key, value) => print("$key=$value"));