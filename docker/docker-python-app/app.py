import sys
import pandas as pd
from datetime import datetime

date = datetime.now()

df = pd.DataFrame({
	"Date": [date]
})

df.to_csv("date_creator.csv", index=False)

print("Hello from inside a custom Docker container!")
print(f"Python Version: {sys.version.split()[0]}")
