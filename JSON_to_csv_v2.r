###Current changes saved on October 31, 2016.
###The following code requires the package jsonlite. Additionally dplyr would be useful to 
### manipulate the data frames futher if one master dataframe is the desired output.

library(jsonlite)


##I have the json file on my desktop which is the home directory for my R
##if this is not the same for you, you will need to change the path to
##represent the correct location

JsonIn <- fromJSON("all_phd_8.json")


########################
###I have designed the following code to only pull out data that is present,
### but all pieces of data are identified via the access ID.
### any variable can be used you just have to alter the codes
### i will comment the first chunk of code heavily and the resulting pieces
### are essentially iterative so I will just include them wihtout comment

####################################################################################
## this snippet looks for students that have cohort information, pulls out their corresponding ID,
##then the ID is repeated for each row of the resulting cohort DF. in the case of cohort there isn't
##a necessity for repeating the ID, but for sake of consistency/just in case it's present

	cohort_id_df <- NULL
	for(i in 1:nrow(JsonIn)) {
	
	#if a student has cohort data then a dataframe of row !=0 will be further
	#maniputlated
		
		if(nrow(JsonIn[[1]][[i]]) != 0){
			
		#pull out cohort information
			cohort_df <- JsonIn[[1]][[i]]
			
		#find the access_id that corresponds to the row of the data frame that has cohort information	
			access_id <- JsonIn[i,5][[12]]
			last_name <- JsonIn[i,5][[2]]
		
		#repeat access_id for as many rows as present in cohort data.frame. this should be just 1	
			access_id2 <- rep(access_id, nrow(cohort_df))
			last_name2 <- rep(last_name, nrow(cohort_df))
		#add access_id to the front of cohort data.frame	
			cohort_id <- cbind(access_id2, last_name2, cohort_df)
			
		#build a data frame that has each student with cohort information	
			cohort_id_df <- rbind(cohort_id_df,cohort_id)
		}
	}
####################################################################################


##now repeat for contact, phd_graduation, visas, qualifying paperwork, and courses


	contact_id_df <- NULL
		for(i in 1:nrow(JsonIn)) {
			
			if(nrow(JsonIn[[2]][[i]]) != 0){
				contact_df <- JsonIn[[2]][[i]]
				access_id <- JsonIn[i,5][[12]]
				last_name <- JsonIn[i,5][[2]]
				access_id2 <- rep(access_id, nrow(contact_df))
				last_name2 <- rep(last_name, nrow(contact_df))
				contact_id <- cbind(access_id2, last_name2, contact_df)
				contact_id_df <- rbind(contact_id_df,contact_id)
			}
		}

	phd_id_df <- NULL
	for(i in 1:nrow(JsonIn)) {
		
		if(nrow(JsonIn[[3]][[i]]) != 0){
			phd_df <- JsonIn[[3]][[i]]
			access_id <- JsonIn[i,5][[12]]
			last_name <- JsonIn[i,5][[2]]
			access_id2 <- rep(access_id, nrow(phd_df))
			last_name2 <- rep(last_name, nrow(phd_df))
			phd_id <- cbind(access_id2, last_name2, phd_df)
			phd_id_df <- rbind(phd_id_df,phd_id)
		}
	}

	visas_id_df <- NULL
	for(i in 1:nrow(JsonIn)) {
		
		if(nrow(JsonIn[[6]][[i]]) != 0){
			visas_df <- JsonIn[[6]][[i]]
			access_id <- JsonIn[i,5][[12]]
			last_name <- JsonIn[i,5][[2]]
			access_id2 <- rep(access_id, nrow(visas_df))
			last_name2 <- rep(last_name, nrow(visas_df))
			visas_id <- cbind(access_id2, last_name2, visas_df)
			visas_id_df <- rbind(visas_id_df,visas_id)
		}
	}

	qualifyingPaper_id_df <- NULL
	for(i in 1:nrow(JsonIn)) {
		
		if(nrow(JsonIn[[7]][[i]]) != 0){
			#for this i've ommitted the comment section
			qualifyingPaper_df <- JsonIn[[7]][[i]][,-2]
			access_id <- JsonIn[i,5][[12]]
			last_name <- JsonIn[i,5][[2]]
			access_id2 <- rep(access_id, nrow(qualifyingPaper_df))
			last_name2 <- rep(last_name, nrow(qualifyingPaper_df))
			qualifyingPaper_id <- cbind(access_id2, last_name2, qualifyingPaper_df)
			qualifyingPaper_id_df <- rbind(qualifyingPaper_id_df,qualifyingPaper_id)
		}
	}

	course_id_df <- NULL
	for(i in 1:nrow(JsonIn)) {
		
		if(nrow(JsonIn[[8]][[i]]) != 0){
			course_df <- JsonIn[[8]][[i]]
			access_id <- JsonIn[i,5][[12]]
			last_name <- JsonIn[i,5][[2]]
			access_id2 <- rep(access_id, nrow(course_df))
			last_name2 <- rep(last_name, nrow(course_df))
			course_id <- cbind(access_id2, last_name2, course_df)
			course_id_df <- rbind(course_id_df,course_id)
		}
	}
	
##since field of study and biographical information are objects not arrays they can be pulled out directly	
	
	field_df <- JsonIn[,4]
	biograph_df <- JsonIn[,5]
	field_biograph_df <- cbind(field_df,biograph_df)
	
	
##becuase some of the variables in some of the csvs contain commas, i've made "|" the separator
##which requires one additional step in Excel 
 	

write.table(cohort_id_df,file= "JSON_cohort_phd_8.txt",na="",sep="|", row.names=FALSE,col.names=TRUE,quote=FALSE)
write.table(contact_id_df,file= "JSON_contact_phd_8.txt",na="",sep="|", row.names=FALSE,col.names=TRUE,quote=FALSE)
write.table(phd_id_df,file= "JSON_phd_phd_8.txt",na="",sep="|", row.names=FALSE,col.names=TRUE,quote=FALSE)
write.table(visas_id_df,file= "JSON_visas_phd_8.txt",na="",sep="|", row.names=FALSE,col.names=TRUE,quote=FALSE)
write.table(qualifyingPaper_id_df,file= "JSON_qualifyingPaper_phd_8.txt",na="",sep="|", row.names=FALSE,col.names=TRUE,quote=FALSE)
write.table(course_id_df,file= "JSON_course_phd_8.txt",na="",sep="|", row.names=FALSE,col.names=TRUE,quote=FALSE)
write.table(field_biograph_df,file= "JSON_field_biograph_phd_8.txt",na="",sep="|", row.names=FALSE,col.names=TRUE,quote=FALSE)







