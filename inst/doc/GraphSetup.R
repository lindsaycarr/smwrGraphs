## ----setup, echo=FALSE, warning=FALSE, message=FALSE---------------------
library(knitr)
library(captioner)
library(rmarkdown)
opts_chunk$set(message=FALSE,warning=FALSE,dev="png")
opts_knit$set(eval.after='fig.cap')
fig_nums <- captioner()

## ------------------------------------------------------------------------
# Load the smwrGraphs package
library(smwrGraphs)
# Generate the random data
set.seed(27036)
X <- rnorm(32)
Y <- X + rnorm(32)
Z <- rnorm(32, sd=1.2)
Zfill <- runif(32, -2, 0)

## ----chunk1--------------------------------------------------------------
# Set up the graphics environment, the equivalent call for an on screen
#  device would be setPage("square")
setPNG()
xyPlot(X, Y)


## ----chunk2--------------------------------------------------------------
setPNG()
xyPlot(X, Y, 
# Change from solod black circles to blue plus signs
Plot=list(symbol="+", color="blue"),
# Set the x-axis range to -2 to 2, for symmetry
xaxis.range=c(-2,2),
# label at the five integral values: -2, -1, 0, 1, 2
xlabels=5,
# can also be manually set: see figure 3
# Change the x- and y-axis titles and end the call
xtitle="Random Data",
ytitle="Correlated Data")


## ----chunk3--------------------------------------------------------------
setPNG()
bigY <- exp(Y)
xyPlot(X, bigY, 
# Change from solod black circles to blue plus signs
Plot=list(symbol="uptri", color="green"),
# Set the x-axis range to -2 to 2, for symmetry
xaxis.range=c(-2,2),
# label at the five integral values: -2, -1, 0, 1, 2
xlabels=c(-2, -1, 0, 1, 2),
yaxis.log=TRUE,
# The default behaviour would be numeric labels for this range.
ylabels=list(labels="Auto", style="scientific"),
# Change the x- and y-axis titles and end the call
xtitle="Random Data",
ytitle="Correlated Data")


## ----chunk4--------------------------------------------------------------
setPNG()
# Create a scatter plot from the X and Y data. The name of the output (AA.pl)
#  is completely arbiutrary, but consistently used through these examples.
AA.pl <- xyPlot(X, Y, Plot=list(name="Correlated Data", color="blue"),
xaxis.range=c(-2,2), xlabels=5,
xtitle="Random Data",
ytitle="Response Data")
# Use the addXY function to add a plot to the graph. The output contains
#  information about both plots and cen be used to create an explanation
#  or legend.
AA.pl <- addXY(X, Z, Plot=list(name="Uncorrelated Data", what="points",
  color="darkred"), current=AA.pl)
# The addExplanation function processes the information in the output to
#  create an explanaiton of the data shown in the plots.
addExplanation(AA.pl, where="ul", title="")


## ----chunk5, fig.height=4------------------------------------------------
setPNG()
# Set the layout for 2 graphs in one row. and allocate room at the top for a graph title
AA.lo <- setLayout(num.cols=2)
# The first graph is the left-most graph
AA.gr <- setGraph(1, AA.lo)
# Create a scatter plot from the X and Y data. 
AA.pl <- xyPlot(X, Y, Plot=list(color="blue"),
  xaxis.range=c(-2,2), xlabels=5,
  xtitle="Random Data", ytitle="Correlated Data",
  margin=AA.gr)
# Add the title
addTitle("A")
# The figure caption should always by the lower-left most graph
addCaption("Figure 5. Example Graphs.")
# Subsequent graphs are placed to the right in each row
AA.gr <- setGraph(2, AA.lo)
# Create a scatter plot from the X and Y data. 
AA.pl <- xyPlot(X, Z, Plot=list(color="darkred"),
  xaxis.range=c(-2,2), xlabels=5,
  xtitle="Random Data", ytitle="Uncorrelated Data",
  margin=AA.gr)
# Add the title
addTitle("B")


## ----chunk6--------------------------------------------------------------
setPNG()
# Set the layout for 2 rows and 2 columns with the explanation in grid cell 2
# Note that num.graphs must be set
AA.lo <- setLayout(num.cols=2, num.rows=2, num.graphs=3, explanation=list(grid=2))
# Print the layout to see how the graph number are assigned to the grid cells
print(AA.lo)
# The first graph (box plot) is in the upper-left corner
AA.gr <- setGraph(1, AA.lo)
AA.bp <- boxPlot(Y, Z, Box=list(type="simple", show.counts=FALSE), 
  xlabels=c("Correlated", "Uncorrelated"))
# The explanation for the box plot can be added now or after the other graphs
AA.gr <- setGraph("explanation", AA.lo)
addExplanation(AA.bp, title=expression(bold("Box Plot Description")))
# Create a scatter plot from the X and Y data. 
AA.gr <- setGraph(2, AA.lo)
AA.pl <- xyPlot(X, Y, Plot=list(color="blue"),
  xaxis.range=c(-2,2), xlabels=5,
  xtitle="Random Data", ytitle="Correlated Data",
  margin=AA.gr)
# ANd the final graph
AA.gr <- setGraph(3, AA.lo)
# Create a scatter plot from the X and Y data. 
AA.pl <- xyPlot(X, Z, Plot=list(color="darkred"),
  xaxis.range=c(-2,2), xlabels=5,
  xtitle="Random Data", ytitle="Uncorrelated Data",
  margin=AA.gr)


## ----chunk7, fig.width=4-------------------------------------------------
setPNG()
# Set the layout for 2 graphs in one column with shared x-axes
AA.lo <- setLayout(num.rows=2, shared.x=1)
# The first graph is the upper graph
AA.gr <- setGraph(1, AA.lo)
# Create a scatter plot from the X and Y data. 
AA.pl <- xyPlot(X, Y, Plot=list(color="blue"),
  xaxis.range=c(-2,2), xlabels=5,
  ytitle="Correlated Data",
  margin=AA.gr)
# The second graph is placed immediately below
AA.gr <- setGraph(2, AA.lo)
# Create a scatter plot from the X and Y data. 
AA.pl <- xyPlot(X, Z, Plot=list(color="darkred"),
  xaxis.range=c(-2,2), xlabels=5,
  xtitle="Random Data", ytitle="Uncorrelated Data",
  margin=AA.gr)


## ----chunk8, fig.width=5-------------------------------------------------
setPNG()
# Set the layout for 2 graphs in one column with shared x-axes
# Create a scatter plot from the X and Z data. 
AA.pl <- xyPlot(X, Z, Plot=list(color="blue"),
  xaxis.range=c(-2,2), xlabels=-5,
  yaxis.range=c(-3,2),
  ytitle="Uncorrelated Data", xtitle="")
# Add the shaded are just above the bottom x-axis
addArea(sort(X), Zfill, ybase=-3, current=AA.pl)
# Now add ticks, labels and title
addAxisLabels("bottom", AA.pl, ticks=TRUE, labels=TRUE, title="X")


