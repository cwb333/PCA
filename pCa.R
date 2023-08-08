
pCa_group <- function(x, ncomp = NULL) {
  
  require(FactoMineR)
  require(factoextra)
  
  num <- 1:ncol(x)
  letters <- LETTERS[1:ncol(x)]
  col_names <- paste0(letters, num)
  colnames(x) <- col_names
  
  x_pca <- PCA(x,  quali.sup = 1, ncp = ncomp, graph = F)
  
  fviz_pca_var(x_pca, col.var = "contrib", gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), repel = T) + theme(text = element_text(size = 15),
                                                                                                                       axis.title = element_text(size = 15),
                                                                                                                       axis.text = element_text(size = 15),
                                                                                                                  aspect.ratio = 1)
  
  fviz_ellipses(x_pca, habillage = x[,1], geom = "point") +   theme(text = element_text(size = 15),
                                                                    
                                                                    axis.title = element_text(size = 15),
                                                                    axis.text = element_text(size = 15),
                                                                    aspect.ratio = 1)


}
