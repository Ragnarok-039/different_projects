import pandas as pd
import plotly.express as px
from dash import Dash, dcc, html

df = pd.read_csv(r'F:\Datasets\games-release-ALL.csv')
df['release'] = pd.to_datetime(df['release'])
df['year_release'] = df['release'].dt.year
df['rating'] = df['rating'].astype(float)

print(df.head())
print(df.columns)

new_df = df[['year_release', 'rating']].groupby('year_release').mean()
print(new_df.head())

app = Dash(__name__)

app.layout = html.Div(children=[
    html.Div(dcc.Dropdown(df['year_release'].unique())),
    html.Div(dcc.Graph(id='new', figure=px.line(df, x='year_release',
                                                y='rating')))])

if __name__ == '__main__':
    app.run_server(debug=True)
