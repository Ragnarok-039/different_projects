import pandas as pd
from dash import Dash, dcc, html

app = Dash(__name__)

df = pd.read_csv(r'F:\Datasets\games-release-ALL.csv')

print(df.head())

app.layout = html.Div([
    dcc.Dropdown(['New York City', 'Montréal', 'San Francisco'], 'Montréal')
])

if __name__ == '__main__':
    app.run_server(debug=True)
