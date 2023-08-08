
pCa_group <- function(x) {
  
  require(FactoMineR)
  require(factoextra)
  
  x_pca <- PCA(x,  quali.sup = 1, graph = F)
  
  fviz_pca_var(x_pca, col.var = "contrib", gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), repel = T) + theme(text = element_text(size = 15),
                                                                                                                       axis.title = element_text(size = 15),
                                                                                                                       axis.text = element_text(size = 15),
                                                                                                                       title = element_blank(),
                                                                                                                  aspect.ratio = 1)
  
}
