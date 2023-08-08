
pCa_ind <- function(x) {
  
  require(FactoMineR)
  require(factoextra)
  
  x_pca <- PCA(x,  quali.sup = 1, graph = F)

  fviz_ellipses(x_pca, habillage = colnames(x[1]), geom = "point") +   theme(text = element_text(size = 15),
                                                                    
                                                                    axis.title = element_text(size = 15),
                                                                    axis.text = element_text(size = 15),
                                                                    title  = element_blank(),
                                                                    aspect.ratio = 1)
  
}
