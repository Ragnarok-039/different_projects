import pandas as pd
import plotly.express as px
from dash import Dash, dcc, html

df = pd.read_csv(r'F:\Datasets\games-release-ALL.csv')
df['release'] = pd.to_datetime(df['release'])
df['year_release'] = df['release'].dt.year
df['rating'] = df['rating'].apply(lambda x: x.strip('%')).astype(float)

print(df.head())
print(df.columns)

new_df = df[['year_release', 'rating']].groupby('year_release').agg('mean')
print(new_df.head())
print(new_df.columns)

app = Dash(__name__)

app.layout = html.Div(children=[
    html.Div(dcc.Dropdown(df['year_release'].unique())),
    html.Div(dcc.Graph(id='new', figure=px.line(new_df, x=new_df.index,
                                                y='rating'))),
    html.Div(dcc.RangeSlider(min(df['year_release'].unique()), max(df['year_release'].unique()), step=1,
                             marks={i: '{}'.format(i) for i in
                                    range(min(df['year_release'].unique()), max(df['year_release'].unique()))}))])

if __name__ == '__main__':
    app.run_server(debug=True)
