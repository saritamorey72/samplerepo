fileConn<-file("/test_mosaic/G3/data_writee.txt")
readLines(("/test_mosaic/G2/data_writee.txt"), fileConn)
close(fileConn)