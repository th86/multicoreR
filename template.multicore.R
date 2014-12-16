#####################################################
#  Script Template for Multicore Computation in R	#
#													#
#  @author Tai-Hsien Ou Yang (to2232@columbia.edu)	#
#													#
#####################################################

#This template is an example of constructing a correlation matrix using foreach package and doMC pacakge.

library(foreach)
library(doMC)

registerDoMC(cores=3) 	#Change cores to register the number of cores for computation

load("mat.rda") 		#Load matrix "mat", we are going to iterate all rows.

iterator = 1:nrow(mat) 	#Generate an iterator

ptm <- proc.time()

foreach( i = iterator, .verbose=FALSE) %dopar% { 
	#Perform computation using each element in the iterator here

	corList=rep(0, nrow(mat)) 

	for( j in (i+1):nrow(mat)  ){
		corList[j]=cor( mat[i,], mat[j,]  )
		if(j%%1000==1)
			cat(i,j,"\n")
	}

	#Save the result from each element to save memory
	save( corList, file=paste( "./output/", i ,".rda",sep="" )  ) 
		
}

total.time =proc.time() - ptm