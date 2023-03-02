# Nationalist Language
Data and setup script from my project on nationalist language. 


## Uses

Currently, the uses of these data are a bit limited. I am still in the process of rebuilding my original corpora due to a data loss during my move from Cleveland to Columbus. However, what remains are the frequency tables (filtered for stopwords) for each party that I analyzed. 

## Included Functionality

In the package is setup.R, which performs the necessary transformations and creates a plotting function. These DataFrames are frequency tables of the tokens contained in the corpora I constructed for each party. These represent a minimal, albet still demonstrative representation of the topical focuses for each party entering 2020. 

I have also packaged **plot_counts()**, which leverages [ggpubr()](https://rpkgs.datanovia.com/ggpubr/) to generate plots for each frequency table. 

### ```setup.R```

Running this file provides you with mutable dataframes of each frequency table.

### ```plot_counts()```

Takes five arguments:
1. `nation`: Frequency table to be plotted. Also supplies figure with [party_name].
2. `viz`: Choice of color for the figure (defaults to Navy)
3. `n_tokens`: Number of tokens to be plotted (defaults to 10)
4. `figure_no`: Number to be added to figure title; determines output name of [save].
5. `save`: Whether or not to render the plot as a .png (defaults to TRUE).
