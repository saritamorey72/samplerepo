fileConn<-file("/test_mosaic/G1/writeG1.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)