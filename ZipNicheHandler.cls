public with sharing class ZipNicheHandler {
    
    public static void updateBeforeInsert(List<Zip_Niche__c> sourceRecords){
		Set<Decimal> year = new Set<Decimal>();
        Set<String> Zipcode_Name = new Set<String>();
        Map<String, Map<Decimal, Zip_Niche__c>> zipMap = new Map<String, Map<Decimal, Zip_Niche__c>>();
        
        Boolean oneYear = false;
        Boolean threeYear = false;
        Boolean fiveYear = false;
        
        for(Zip_Niche__c tempZip : sourceRecords){
            year.add(tempZip.year__c - 1);
            year.add(tempZip.year__c - 3);
            year.add(tempZip.year__c - 5);
            Zipcode_Name.add(tempZip.Zipcode_Name__c);
        }
        
        List<Zip_Niche__c> oldZip = [Select id, Median_Home_Value__c, Median_Household_Income__c, Median_Rent__c, Total_Population__c, Unemploy_Rate__c,
                                         Commute_Time_45_59__c, Commute_Time_60_89__c, Commute_Time_Over_90__c, Diversity_Breakdown_African_American__c,
                                         Diversity_Breakdown_Hispanic__c, Diversity_Breakdown_White__c, Edu_Breakdown_College_Less__c, Edu_Breakdown_College_Some__c, 
                                         Edu_Breakdown_Degree_Bachelors__c, Edu_Breakdown_Degree_Doctorate__c, Edu_Breakdown_Degree_Masters__c, Edu_Breakdown_High_school__c, 
                                         Grade_Access_To_Bars__c, Grade_Access_To_Coffee_Shops__c, Grade_Access_To_Nightlife__c, Grade_Access_To_Outdoor_Activities__c, 
                                         Grade_Access_To_Restaurants__c, Grade_Health_And_Fitness__c, Grade_Overall__c, Grade_Public_Schools__c, Day_On_Market__c, 
                                     	 Grade_Access_To_Bars_Score__c, Grade_Access_To_Coffee_Shops_Score__c, Grade_Access_To_Nightlife_Score__c, Grade_Access_To_Outdoor_Activities_Score__c, 
                                         Grade_Access_To_Restaurants_Score__c, Grade_Health_And_Fitness_Score__c, Grade_Overall_Score__c, Zipcode_Name__c, year__c                                            
                                         from Zip_Niche__c where year__c in :year and Zipcode_Name__c in :Zipcode_Name];/*
        List<Zip_Niche__c> threeYearZip = [];
        List<Zip_Niche__c> fiveYearZip = [];*/
        for(Zip_Niche__c zip_tmp : oldZip){
            if(!zipMap.containsKey(zip_tmp.Zipcode_Name__c)){
                zipMap.put(zip_tmp.Zipcode_Name__c, new Map<Decimal, Zip_Niche__c>{zip_tmp.Year__c => zip_tmp});
            }
            else{
                zipMap.get(zip_tmp.Zipcode_Name__c).put(zip_tmp.Year__c, zip_tmp);
            }
        }
        
        for(Zip_Niche__c zip_tmp : sourceRecords){
            if(zipMap.containsKey(zip_tmp.Zipcode_Name__c) && zipMap.get(zip_tmp.Zipcode_Name__c).containsKey(zip_tmp.year__c - 1))
                oneYear = true;
            else
                oneYear = false;
            if(zipMap.containsKey(zip_tmp.Zipcode_Name__c) && zipMap.get(zip_tmp.Zipcode_Name__c).containsKey(zip_tmp.year__c - 3))
                threeYear = true;
            else
                threeYear = false;
            if(zipMap.containsKey(zip_tmp.Zipcode_Name__c) && zipMap.get(zip_tmp.Zipcode_Name__c).containsKey(zip_tmp.year__c - 5))
                fiveYear = true;
            else
                fiveYear = false;
            
            zip_tmp.Median_Home_Value_1_Year__c = oneYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 1).Median_Home_Value__c : 1;
			zip_tmp.Median_Household_Income_1_Years__c = oneYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 1).Median_Household_Income__c : 1;
			zip_tmp.Median_Rent_1_Years__c = oneYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 1).Median_Rent__c : 1;
			zip_tmp.Total_Population_1_Years__c = oneYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 1).Total_Population__c : 1;
			zip_tmp.Unemploy_Rate_1_Year__c = oneYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 1).Unemploy_Rate__c : 1;
            zip_tmp.Commute_Time_45_59_3_Year__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Commute_Time_45_59__c : 1; 
            zip_tmp.Commute_Time_60_89_3_Year__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Commute_Time_60_89__c : 1;
			zip_tmp.Commute_Time_Over_90_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Commute_Time_Over_90__c : 1;
			zip_tmp.Diversity_Breakdown_African_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Diversity_Breakdown_African_American__c : 1;
			zip_tmp.Diversity_Breakdown_Hispanic_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Diversity_Breakdown_Hispanic__c : 1;
			zip_tmp.Diversity_Breakdown_White_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Diversity_Breakdown_White__c : 1;
			zip_tmp.Edu_Breakdown_College_Less_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Edu_Breakdown_College_Less__c : 1;
			zip_tmp.Edu_Breakdown_College_Some_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Edu_Breakdown_College_Some__c : 1;
			zip_tmp.Edu_Breakdown_Degree_Bachelors_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Edu_Breakdown_Degree_Bachelors__c : 1;
			zip_tmp.Edu_Breakdown_Degree_Doctorate_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Edu_Breakdown_Degree_Doctorate__c : 1;
			zip_tmp.Edu_Breakdown_Degree_Masters_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Edu_Breakdown_Degree_Masters__c : 1;
			zip_tmp.Edu_Breakdown_High_school_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Edu_Breakdown_High_school__c : 1;
			zip_tmp.Grade_Access_To_Bars_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Grade_Access_To_Bars_Score__c : 1;
			zip_tmp.Grade_Access_To_Coffee_Shops_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Grade_Access_To_Coffee_Shops_Score__c : 1;
			zip_tmp.Grade_Access_To_Nightlife_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Grade_Access_To_Nightlife_Score__c : 1;
			zip_tmp.Grade_Access_To_Outdoor_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Grade_Access_To_Outdoor_Activities_Score__c : 1;
			zip_tmp.Grade_Access_To_Restaurants_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Grade_Access_To_Restaurants_Score__c : 1;
			zip_tmp.Grade_Health_And_Fitness_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Grade_Health_And_Fitness_Score__c : 1;
			zip_tmp.Grade_Overall_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Grade_Overall_Score__c : 1;
			zip_tmp.Grade_Public_Schools_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Grade_Public_Schools_Score__c : 1;
			zip_tmp.Median_Home_Value_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Median_Home_Value__c : 1;
			zip_tmp.Median_Household_Income_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Median_Household_Income__c : 1;
			zip_tmp.Median_Rent_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Median_Rent__c : 1;
			zip_tmp.Total_Population_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Total_Population__c : 1;
			zip_tmp.Unemploy_Rate_3_Years__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Unemploy_Rate__c : 1;
            zip_tmp.Day_On_Market_3_Year__c = threeYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 3).Day_On_Market__c : 1;
            zip_tmp.Median_Home_Value_5_Years__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Median_Home_Value__c : 1;
			zip_tmp.Median_Household_Income_5_Years__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Median_Household_Income__c : 1;
			zip_tmp.Median_Rent_5_Years__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Median_Rent__c : 1;
			zip_tmp.Total_Population_5_Years__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Total_Population__c : 1;
			zip_tmp.Unemploy_Rate_5_Years__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Unemploy_Rate__c : 1;
            zip_tmp.Commute_Time_45_59_5_Years__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Commute_Time_45_59__c : 1;
            zip_tmp.Commute_Time_60_89_5_Years__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Commute_Time_60_89__c : 1;
            zip_tmp.Commute_Time_Over_90_5_Years__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Commute_Time_Over_90__c : 1;
            zip_tmp.Diversity_Breakdown_Hispanic_5_Years__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Diversity_Breakdown_Hispanic__c : 1;
            zip_tmp.Diversity_Breakdown_White_5_Years__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Diversity_Breakdown_White__c : 1;
            zip_tmp.Edu_Breakdown_Degree_Bachelors_5_Years__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Edu_Breakdown_Degree_Bachelors__c : 1;
            zip_tmp.Edu_Breakdown_Degree_Doctorate_5_Years__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Edu_Breakdown_Degree_Doctorate__c : 1;
            zip_tmp.Grade_Access_To_Bars_5_Years__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Grade_Access_To_Bars__c : 'No Score';
            zip_tmp.Grade_Access_To_Coffee_Shops_5_Year__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Grade_Access_To_Coffee_Shops_Score__c : 1;
            zip_tmp.Grade_Access_To_Nightlife_5Y_Score__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Grade_Access_To_Nightlife_Score__c : 1;
            zip_tmp.Access_To_Outdoor_Activities_5Y__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Grade_Access_To_Outdoor_Activities_Score__c : 1;
            zip_tmp.Access_To_Restaurants_5_Year__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Grade_Access_To_Restaurants_Score__c : 1;
            zip_tmp.Health_And_Fitness_5_Year__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Grade_Health_And_Fitness_Score__c : 1;
            zip_tmp.Grade_Overall_5_Year__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Grade_Overall_Score__c : 1;
            zip_tmp.Grade_Public_School_5_Year__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Grade_Public_Schools_Score__c : 1;
            zip_tmp.Grade_Weather_5_Year__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Grade_Weather_Score__c : 1;
            zip_tmp.Diversity_Breakdown_African_American_5__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Diversity_Breakdown_African_American__c : 1;
            zip_tmp.Edu_Breakdown_Degree_Masters_5_Years__c = fiveYear ? zipMap.get(zip_tmp.Zipcode_Name__c).get(zip_tmp.year__c - 5).Edu_Breakdown_Degree_Masters__c : 1;
        }
    }
    
     public static void updateBeforeUpdate(List<Zip_Niche__c> sourceRecords){
         
         Decimal Delta5y = 0;
         Decimal Delta3y = 0;
         Decimal Delta1y = 0;
         for(Zip_Niche__c tmpZip : sourceRecords){
             //45-59
             tmpZip.Commute_Time_45_59_Score__c = getCommute_Time_45_59_Score(tmpZip.Commute_Time_45_59__c) * (tmpZip.Commute_Time_45_59_Factor__c != 0 ? tmpZip.Commute_Time_45_59_Factor__c : 1);
             Delta5y = (tmpZip.Commute_Time_45_59__c - tmpZip.Commute_Time_45_59_5_Years__c) / tmpZip.Commute_Time_45_59__c;
             tmpZip.Commute_Time_45_59_5_Years_Delta_Score__c = getCommute_Time_45_59_Delta_Score(Delta5y) * (tmpZip.Commute_Time_45_59_5Y_Factor__c != 0 ? tmpZip.Commute_Time_45_59_5Y_Factor__c : 1);
             //60-89
             tmpZip.Commute_Time_60_89_Score__c = getCommute_Time_60_89_Score(tmpZip.Commute_Time_60_89__c) * (tmpZip.Commute_Time_60_89_Factor__c != 0 ? tmpZip.Commute_Time_60_89_Factor__c : 1);
             Delta5y = (tmpZip.Commute_Time_60_89__c - tmpZip.Commute_Time_60_89_5_Years__c) / tmpZip.Commute_Time_60_89__c;
             tmpZip.Commute_Time_60_89_5_Years_Delta_Score__c = getCommute_Time_60_89_Delta_Score(Delta5y) * (tmpZip.Commute_Time_60_89_5Y_Delta_Factor__c != 0 ? tmpZip.Commute_Time_60_89_5Y_Delta_Factor__c : 1);
             // 90+
             tmpZip.Commute_Time_Over_90_Score__c = getCommute_Time_Over_90_Score(tmpZip.Commute_Time_Over_90__c) * (tmpZip.Commute_Time_Over_90_Factor__c != 0 ? tmpZip.Commute_Time_Over_90_Factor__c : 1);
             Delta5y = (tmpZip.Commute_Time_Over_90__c - tmpZip.Commute_Time_Over_90_5_Years__c) / tmpZip.Commute_Time_Over_90__c;
             tmpZip.Commute_Time_Over_90_5Y_Delta_Score__c = getCommute_Time_Over_90_5Y_Delta_Score(Delta5y) * (tmpZip.Commute_Time_Over_90_5Y_Delta_Factor__c != 0 ? tmpZip.Commute_Time_Over_90_5Y_Delta_Factor__c : 1);
   			 // Diversity_Breakdown_African_American__c
             tmpZip.Diversity_Breakdown_African_Score__c = getDiversity_Breakdown_African_Score(tmpZip.Diversity_Breakdown_African_American__c) * (tmpZip.Diversity_Breakdown_African_American_Fac__c != 0 ? tmpZip.Diversity_Breakdown_African_American_Fac__c : 1);
             Delta5y = (tmpZip.Diversity_Breakdown_African_American__c - tmpZip.Diversity_Breakdown_African_American_5__c) / tmpZip.Diversity_Breakdown_African_American__c;
             tmpZip.Diversity_Breakdown_African_5Y_D_Score__c = getDiversity_Breakdown_African_5Y_Delta_Score(Delta5y) * (tmpZip.Diversity_Breakdown_African_American_5Fa__c != 0 ? tmpZip.Diversity_Breakdown_African_American_5Fa__c : 1);
             // Diversity_Breakdown_Hispanic__c
             tmpZip.Diversity_Breakdown_Hispanic_Score__c = getDiversity_Breakdown_Hispanic_Score(tmpZip.Diversity_Breakdown_Hispanic__c) * (tmpZip.Diversity_Breakdown_HisPanic_Factor__c != 0 ? tmpZip.Diversity_Breakdown_HisPanic_Factor__c : 1);
             Delta5y = (tmpZip.Diversity_Breakdown_Hispanic__c - tmpZip.Diversity_Breakdown_Hispanic_5_Years__c) / tmpZip.Diversity_Breakdown_Hispanic__c;
             tmpZip.Diversity_Breakdown_Hispanic_5Y_Score__c = getDiversity_Breakdown_Hispanic_5Y_Score(Delta5y) * (tmpZip.Diversity_Breakdown_Hispanic_5Y_Factor__c != 0 ? tmpZip.Diversity_Breakdown_Hispanic_5Y_Factor__c : 1);
             // Diversity_Breakdown_White__c
             tmpZip.Diversity_Breakdown_White_Score__c = getDiversity_Breakdown_White_Score(tmpZip.Diversity_Breakdown_White__c) * (tmpZip.Diversity_Breakdown_White_Factor__c != 0 ? tmpZip.Diversity_Breakdown_White_Factor__c : 1);
             Delta5y = (tmpZip.Diversity_Breakdown_White__c - tmpZip.Diversity_Breakdown_White_5_Years__c) / tmpZip.Diversity_Breakdown_White__c;
             tmpZip.Diversity_Breakdown_White_5_Year_Score__c = getDiversity_Breakdown_White_5Y_Score(Delta5y) * (tmpZip.Diversity_Breakdown_White_5Y_Factor__c != 0 ? tmpZip.Diversity_Breakdown_White_5Y_Factor__c : 1);
        	 // Edu_Breakdown_Degree_Bachelors__c
             tmpZip.Edu_Breakdown_Degree_Bachelors_Score__c = getEdu_Breakdown_Degree_Bachelors_Score(tmpZip.Edu_Breakdown_Degree_Bachelors__c) * (tmpZip.Edu_Breakdown_Degree_Bachelors_Factor__c != 0 ? tmpZip.Edu_Breakdown_Degree_Bachelors_Factor__c : 1);
             Delta5y = (tmpZip.Edu_Breakdown_Degree_Bachelors__c - tmpZip.Edu_Breakdown_Degree_Bachelors_5_Years__c) / tmpZip.Edu_Breakdown_Degree_Bachelors__c;
             tmpZip.Edu_Breakdown_Degree_Bachelors_5Y_Score__c = getEdu_Breakdown_Degree_Bachelors_5Y_Score(Delta5y) * (tmpZip.Edu_Breakdown_Degree_Bachelors_5_Y_Facto__c != 0 ? tmpZip.Edu_Breakdown_Degree_Bachelors_5_Y_Facto__c : 1);
        	 // Edu_Breakdown_Degree_Masters__c
             tmpZip.Edu_Breakdown_Degree_Masters_Score__c = getEdu_Breakdown_Degree_Masters_Score(tmpZip.Edu_Breakdown_Degree_Masters__c) * (tmpZip.Edu_Breakdown_Degree_Masters_Factor__c != 0 ? tmpZip.Edu_Breakdown_Degree_Masters_Factor__c : 1);
             Delta5y = (tmpZip.Edu_Breakdown_Degree_Masters__c - tmpZip.Edu_Breakdown_Degree_Masters_5_Years__c) / tmpZip.Edu_Breakdown_Degree_Masters__c;
             tmpZip.Edu_Breakdown_Degree_Masters_5Y_Score__c = getEdu_Breakdown_Degree_Masters_5Y_Score(Delta5y) * (tmpZip.Edu_Breakdown_Degree_Masters_5Y_Facto__c != 0 ? tmpZip.Edu_Breakdown_Degree_Masters_5Y_Facto__c : 1);
        	 // Edu_Breakdown_Degree_Doctorate__c
             tmpZip.Edu_Breakdown_Degree_Doctorate_Score__c = getEdu_Breakdown_Degree_Doctorate_Score(tmpZip.Edu_Breakdown_Degree_Doctorate__c) * (tmpZip.Edu_Breakdown_Degree_Doctorate_Factor__c != 0 ? tmpZip.Edu_Breakdown_Degree_Doctorate_Factor__c : 1);
             Delta5y = (tmpZip.Edu_Breakdown_Degree_Doctorate__c - tmpZip.Edu_Breakdown_Degree_Doctorate_5_Years__c) / tmpZip.Edu_Breakdown_Degree_Doctorate__c;
             tmpZip.Edu_Breakdown_Degree_Doctorate_5Y_Score__c = getEdu_Breakdown_Degree_Doctorate_5Y_Score(Delta5y) * (tmpZip.Edu_Breakdown_Degree_Doctorate_5Y_Fac__c != 0 ? tmpZip.Edu_Breakdown_Degree_Doctorate_5Y_Fac__c : 1);
        	// Grade_Access_To_Bars__c
             tmpZip.Grade_Access_To_Bars_Factored_Score__c = tmpZip.Grade_Access_To_Bars_Score__c * (tmpZip.Grade_Access_To_Bars_Factor__c != 0 ? tmpZip.Grade_Access_To_Bars_Factor__c : 1);
             Delta5y = (tmpZip.Grade_Access_To_Bars_Score__c - tmpZip.Grade_Access_To_Bars_5_Years_Score__c) / tmpZip.Grade_Access_To_Bars_Score__c;
             tmpZip.Grade_Access_To_Bars_5_Y_Factored_Score__c = getGrade_Access_To_Bars_5_Y_Factored_Score(Delta5y) * (tmpZip.Grade_Access_To_Bars_5Y_Factor__c != 0 ? tmpZip.Grade_Access_To_Bars_5Y_Factor__c : 1);
        	// Grade_Access_To_Coffee_Shops__c
             tmpZip.Access_To_Coffee_Shops_Factored_Score__c = tmpZip.Grade_Access_To_Coffee_Shops_Score__c * (tmpZip.Grade_Access_To_Coffee_Shops_Factor__c != 0 ? tmpZip.Grade_Access_To_Coffee_Shops_Factor__c : 1);
             Delta5y = (tmpZip.Grade_Access_To_Coffee_Shops_Score__c - tmpZip.Grade_Access_To_Coffee_Shops_5_Year__c) / tmpZip.Grade_Access_To_Coffee_Shops_Score__c;
             tmpZip.Grade_Access_To_Coffee_Shops_5Y_Score__c = getGrade_Access_To_Coffee_Shops_5Y_Score(Delta5y) * (tmpZip.Grade_Access_To_Coffee_Shops_5Y_Factor__c != 0 ? tmpZip.Grade_Access_To_Coffee_Shops_5Y_Factor__c : 1);
        	// Grade_Access_To_Nightlife_Score__c
             tmpZip.Grade_Access_To_Nightlife_Factored_Score__c = tmpZip.Grade_Access_To_Nightlife_Score__c * (tmpZip.Grade_Access_To_Nightlife_Factor__c != 0 ? tmpZip.Grade_Access_To_Nightlife_Factor__c : 1);
             Delta5y = (tmpZip.Grade_Access_To_Nightlife_Score__c - tmpZip.Grade_Access_To_Nightlife_5Y_Score__c) / tmpZip.Grade_Access_To_Nightlife_Score__c;
             tmpZip.Access_To_Nightlife_5Y_Factored_Score__c = getAccess_To_Nightlife_5Y_Factored_Score(Delta5y) * (tmpZip.Grade_Access_To_Nightlife_5Y_Factor__c != 0 ? tmpZip.Grade_Access_To_Nightlife_5Y_Factor__c : 1);
        	// Grade_Access_To_Outdoor_Activities__c
             tmpZip.Access_To_Outdoor_Activities_Factored_Sc__c = tmpZip.Grade_Access_To_Outdoor_Activities_Score__c * (tmpZip.Access_To_Outdoor_Activities_Factor__c != 0 ? tmpZip.Access_To_Outdoor_Activities_Factor__c : 1);
             Delta5y = (tmpZip.Grade_Access_To_Outdoor_Activities_Score__c - tmpZip.Access_To_Outdoor_Activities_5Y__c) / tmpZip.Grade_Access_To_Outdoor_Activities_Score__c;
             tmpZip.Outdoor_Activities_5Y_Factored_Score__c = getOutdoor_Activities_5Y_Factored_Score(Delta5y) * (tmpZip.Access_To_Outdoor_Activities_5Y_Factor__c != 0 ? tmpZip.Access_To_Outdoor_Activities_5Y_Factor__c : 1);
        	// Grade_Access_To_Restaurants__c
             tmpZip.Access_To_Restaurants_Factored_Score__c = tmpZip.Grade_Access_To_Restaurants_Score__c * (tmpZip.Access_To_Restaurants_Factor__c != 0 ? tmpZip.Access_To_Restaurants_Factor__c : 1);
             Delta5y = (tmpZip.Grade_Access_To_Restaurants_Score__c - tmpZip.Access_To_Restaurants_5_Year__c) / tmpZip.Grade_Access_To_Restaurants_Score__c;
             tmpZip.Access_To_Restaurants_5Y_Factored_Score__c = getAccess_To_Restaurants_5Y_Factored_Score(Delta5y) * (tmpZip.Access_To_Restaurants_5Y_Factor__c != 0 ? tmpZip.Access_To_Restaurants_5Y_Factor__c : 1);
       		 // Grade_Health_And_Fitness__c
             tmpZip.Health_And_Fitness_Factored_Score__c = tmpZip.Grade_Health_And_Fitness_Score__c * (tmpZip.Health_And_Fitness_Factor__c != 0 ? tmpZip.Health_And_Fitness_Factor__c : 1);
             Delta5y = (tmpZip.Grade_Health_And_Fitness_Score__c - tmpZip.Health_And_Fitness_5_Year__c) / tmpZip.Grade_Health_And_Fitness_Score__c;
             tmpZip.Health_And_Fitness_5Y_Factored_Score__c = getHealth_And_Fitness_5Y_Factored_Score(Delta5y) * (tmpZip.Health_And_Fitness_5Y_Factor__c != 0 ? tmpZip.Health_And_Fitness_5Y_Factor__c : 1);
        	// Grade_Overall__c
             tmpZip.Grade_Overall_Factored_Score__c = tmpZip.Grade_Overall_Score__c * (tmpZip.Grade_Overall_Factor__c != 0 ? tmpZip.Grade_Overall_Factor__c : 1);
             Delta5y = (tmpZip.Grade_Overall_Score__c - tmpZip.Grade_Overall_5_Year__c) / tmpZip.Grade_Overall_Score__c;
             tmpZip.Grade_Overall_5Y_Factored_Score__c = getGrade_Overall_5Y_Factored_Score(Delta5y) * (tmpZip.Grade_Overall_5Y_Factor__c != 0 ? tmpZip.Grade_Overall_5Y_Factor__c : 1);
        	// Grade_Public_Schools__c
             tmpZip.Grade_Public_School_Factored_Score__c = tmpZip.Grade_Public_Schools_Score__c * (tmpZip.Grade_Public_School_Factor__c != 0 ? tmpZip.Grade_Public_School_Factor__c : 1);
             Delta5y = (tmpZip.Grade_Public_Schools_Score__c - tmpZip.Grade_Public_School_5_Year__c) / tmpZip.Grade_Public_Schools_Score__c;
             tmpZip.Grade_Public_School_5Y_Factored_Score__c = getGrade_Public_School_5Y_Factored_Score(Delta5y) * (tmpZip.Grade_Public_School_5Y_Factor__c != 0 ? tmpZip.Grade_Public_School_5Y_Factor__c : 1);
       		 // Grade_Weather__c
             tmpZip.Grade_Weather_Factored_Score__c = tmpZip.Grade_Weather_Score__c * (tmpZip.Grade_Weather_Factor__c != 0 ? tmpZip.Grade_Weather_Factor__c : 1);
             Delta5y = (tmpZip.Grade_Weather_Score__c - tmpZip.Grade_Weather_5_Year__c) / tmpZip.Grade_Weather_Score__c;
             tmpZip.Grade_Weather_5Y_Factored_Score__c = getGrade_Weather_5Y_Factored_Score(Delta5y) * (tmpZip.Grade_Weather_5Y_Factor__c != 0 ? tmpZip.Grade_Weather_5Y_Factor__c : 1);
        	// Home_Type_Mobile_Home_Score__c
             tmpZip.Mobile_Home_Factored_Score__c = tmpZip.Home_Type_Mobile_Home_Score__c * (tmpZip.Mobile_Home_Factor__c != 0 ? tmpZip.Mobile_Home_Factor__c : 1);
             //Delta5y = (tmpZip.Grade_Weather_Score__c - tmpZip.Grade_Weather_5_Year__c) / tmpZip.Grade_Weather_Score__c;
             //tmpZip.Grade_Weather_5Y_Factored_Score__c = getGrade_Weather_5Y_Factored_Score(Delta5y) * (tmpZip.Grade_Weather_5Y_Factor__c != 0 ? tmpZip.Grade_Weather_5Y_Factor__c : 1);
        	
             // Median_Home_Value__c
             tmpZip.Median_Home_Value_Factored_Score__c = getMedian_Home_Value_Factored_Score(tmpZip.Median_Home_Value__c) * (tmpZip.Median_Home_Value_Factor__c != 0 ? tmpZip.Median_Home_Value_Factor__c : 1);
             Delta5y = (tmpZip.Median_Home_Value__c - tmpZip.Median_Home_Value_5_Years__c) / tmpZip.Median_Home_Value__c;
             Delta3y = (tmpZip.Median_Home_Value__c - tmpZip.Median_Home_Value_3_Years__c) / tmpZip.Median_Home_Value__c;
             Delta1y = (tmpZip.Median_Home_Value__c - tmpZip.Median_Home_Value_1_Year__c) / tmpZip.Median_Home_Value__c;
             tmpZip.Median_Home_Value_1Y_Factored_Score__c = getMedian_Home_Value_1Y_Factored_Score(Delta1y) * (tmpZip.Median_Home_Value_1Y_Factor__c != 0 ? tmpZip.Median_Home_Value_1Y_Factor__c : 1);
             tmpZip.Median_Home_Value_3Y_Factored_Score__c = getMedian_Home_Value_3Y_Factored_Score(Delta3y) * (tmpZip.Median_Home_Value_3Y_Factor__c != 0 ? tmpZip.Median_Home_Value_3Y_Factor__c : 1);
             tmpZip.Median_Home_Value_5Y_Factored_Score__c = getMedian_Home_Value_5Y_Factored_Score(Delta5y) * (tmpZip.Median_Home_Value_5Y_Factor__c != 0 ? tmpZip.Median_Home_Value_5Y_Factor__c : 1);
        
             // Median_Household_Income__c
             tmpZip.Median_Household_Income_Factored_Score__c = getMedian_Household_Income_Factored_Score(tmpZip.Median_Household_Income__c) * (tmpZip.Median_Household_Income_Factor__c != 0 ? tmpZip.Median_Household_Income_Factor__c : 1);
             //Delta5y = (tmpZip.Grade_Weather_Score__c - tmpZip.Grade_Weather_5_Year__c) / tmpZip.Grade_Weather_Score__c;
             //tmpZip.Grade_Weather_5Y_Factored_Score__c = getGrade_Weather_5Y_Factored_Score(Delta5y) * (tmpZip.Grade_Weather_5Y_Factor__c != 0 ? tmpZip.Grade_Weather_5Y_Factor__c : 1);
        	// Median_Rent__c
             tmpZip.Median_Rent_Factored_Score__c = getMedian_Rent_Factored_Score(tmpZip.Median_Rent__c) * (tmpZip.Median_Rent_Factor__c != 0 ? tmpZip.Median_Rent_Factor__c : 1);
             //Delta5y = (tmpZip.Grade_Weather_Score__c - tmpZip.Grade_Weather_5_Year__c) / tmpZip.Grade_Weather_Score__c;
             //tmpZip.Grade_Weather_5Y_Factored_Score__c = getGrade_Weather_5Y_Factored_Score(Delta5y) * (tmpZip.Grade_Weather_5Y_Factor__c != 0 ? tmpZip.Grade_Weather_5Y_Factor__c : 1);
        	
             // Total_Population__c
             tmpZip.Total_Population_Factored_Score__c = getTotal_Population_Factored_Score(tmpZip.Total_Population__c) * (tmpZip.Total_Population_Factor__c != 0 ? tmpZip.Total_Population_Factor__c : 1);
             Delta5y = (tmpZip.Total_Population__c - tmpZip.Total_Population_5_Years__c) / tmpZip.Total_Population__c;
             Delta3y = (tmpZip.Total_Population__c - tmpZip.Total_Population_3_Years__c) / tmpZip.Total_Population__c;
             Delta1y = (tmpZip.Total_Population__c - tmpZip.Total_Population_1_Years__c) / tmpZip.Total_Population__c;
             tmpZip.Total_Population_1Y_Factored_Score__c = getTotal_Population_1Y_Factored_Score(Delta1y) * (tmpZip.Total_Population_1Y_Factor__c != 0 ? tmpZip.Total_Population_1Y_Factor__c : 1);
             tmpZip.Total_Population_3Y_Factored_Score__c = getTotal_Population_3Y_Factored_Score(Delta3y) * (tmpZip.Total_Population_3Y_Factor__c != 0 ? tmpZip.Total_Population_3Y_Factor__c : 1);
             tmpZip.Total_Population_5Y_Factored_Score__c = getTotal_Population_5Y_Factored_Score(Delta5y) * (tmpZip.Total_Population_5Y_Factor__c != 0 ? tmpZip.Total_Population_5Y_Factor__c : 1);
        	// Unemploy_Rate__c
             tmpZip.Unemploy_Rate_Factored_Score__c = getUnemploy_Rate_Factored_Score(tmpZip.Unemploy_Rate__c) * (tmpZip.Unemploy_Rate_Factor__c != 0 ? tmpZip.Unemploy_Rate_Factor__c : 1);
             Delta5y = (tmpZip.Unemploy_Rate__c - tmpZip.Unemploy_Rate_5_Years__c) / tmpZip.Unemploy_Rate__c;
             Delta3y = (tmpZip.Unemploy_Rate__c - tmpZip.Unemploy_Rate_3_Years__c) / tmpZip.Unemploy_Rate__c;
             Delta1y = (tmpZip.Unemploy_Rate__c - tmpZip.Unemploy_Rate_1_Year__c) / tmpZip.Unemploy_Rate__c;
             tmpZip.Unemploy_Rate_1Y_Factored_Score__c = getUnemploy_Rate_1Y_Factored_Score(Delta1y) * (tmpZip.Unemploy_Rate_1Y_Factor__c != 0 ? tmpZip.Unemploy_Rate_1Y_Factor__c : 1);
             tmpZip.Unemploy_Rate_3Y_Factored_Score__c = getUnemploy_Rate_3Y_Factored_Score(Delta3y) * (tmpZip.Unemploy_Rate_3Y_Factor__c != 0 ? tmpZip.Unemploy_Rate_3Y_Factor__c : 1);
             tmpZip.Unemploy_Rate_5Y_Factored_Score__c = getUnemploy_Rate_5Y_Factored_Score(Delta5y) * (tmpZip.Unemploy_Rate_5Y_Factor__c != 0 ? tmpZip.Unemploy_Rate_5Y_Factor__c : 1);
        	// Day_On_Market__c
             tmpZip.Day_On_Market_Factored_Score__c = getDay_On_Market_Factored_Score(tmpZip.Day_On_Market__c) * (tmpZip.Day_On_Market_Factor__c != 0 ? tmpZip.Day_On_Market_Factor__c : 1);
             Delta3y = (tmpZip.Day_On_Market__c - tmpZip.Day_On_Market_3_Year__c) / tmpZip.Day_On_Market__c;
             tmpZip.Day_On_Market_3Y_Factored_Score__c = getDay_On_Market_3Y_Factored_Score(Delta3y) * (tmpZip.Day_On_Market_3Y_Factor__c != 0 ? tmpZip.Day_On_Market_3Y_Factor__c : 1);
             // Home_Construction_Year__c
             tmpZip.Home_Construction_Year_Factored_Score__c = getHome_Construction_Year_Factored_Score(tmpZip.Home_Construction_Year__c) * (tmpZip.Home_Construction_Year_Factor__c != 0 ? tmpZip.Home_Construction_Year_Factor__c : 1);
             //Delta3y = (tmpZip.Day_On_Market__c - tmpZip.Day_On_Market_3_Year__c) / tmpZip.Day_On_Market__c;
             //tmpZip.Day_On_Market_3Y_Factored_Score__c = getDay_On_Market_3Y_Factored_Score(Delta3y) * (tmpZip.Day_On_Market_3Y_Factor__c != 0 ? tmpZip.Day_On_Market_3Y_Factor__c : 1);
             
         }
     	
     }
    
    // ===================== Private Functions ===================================
	
    // Home_Construction_Year------------------------
    private static Integer getHome_Construction_Year_Factored_Score(Decimal Delta){
        if(Delta > 2010)
            return 20;
        else if(Delta > 2000)
            return 15;
        else if(Delta > 1990)
            return 10;
        else if(Delta > 1980)
            return 0;
        else if(Delta > 1970)
            return -10;
        else if(Delta > 1960)
            return -20;
        else if(Delta > 1950)
            return -30;
        else if(Delta > 1940)
            return -40;
        else
            return 0;
    } 
    
    // Day_On_Market------------------------
    private static Integer getDay_On_Market_Factored_Score(Decimal Delta){
        if(Delta > 100)
            return -30;
        else if(Delta > 80)
            return -20;
        else if(Delta > 60)
            return -15;
        else if(Delta > 50)
            return -10;
        else if(Delta > 40)
            return 0;
        else if(Delta > 35)
            return 10;
        else if(Delta > 30)
            return 20;
        else if(Delta > 25)
            return 30;
        else if(Delta > 20)
            return 35;
        else if(Delta > 0)
            return 40;
        else
            return 0;
    } 
    
    private static Integer getDay_On_Market_3Y_Factored_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
        
    // Unemploy_Rate------------------------
    private static Integer getUnemploy_Rate_Factored_Score(Decimal Delta){
        if(Delta > 0.15)
            return -40;
        else if(Delta > 100000)
            return 40;
        else if(Delta > 80000)
            return 30;
        else if(Delta > 60000)
            return 20;
        else if(Delta > 40000)
            return 5;
        else if(Delta > 20000)
            return -10;
        else if(Delta > 10000)
            return -25;
        else if(Delta > 5000)
            return -35;
        else if(Delta > 1000)
            return -40;
        else if(Delta > 0)
            return -50;
        else
            return 0;
    } 
    
    private static Integer getUnemploy_Rate_1Y_Factored_Score(Decimal Delta){
        if(Delta > 0.01)
            return 25;
        else if(Delta > 0.08)
            return 20;
        else if(Delta > 0.06)
            return 15;
        else if(Delta > 0.04)
            return 10;
        else if(Delta > 0.02)
            return 5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.04)
            return -8;
        else if(Delta > -0.1)
            return -20;
        else if(Delta > -0.15)
            return -30;
        else if(Delta > -0.2)
            return -40;
        else if(Delta > -0.99)
            return -50;
        else
            return 0;
    } 
    
    private static Integer getUnemploy_Rate_3Y_Factored_Score(Decimal Delta){
        if(Delta > 0.15)
            return 25;
        else if(Delta > 0.1)
            return 25;
        else if(Delta > 0.06)
            return 15;
        else if(Delta > 0.04)
            return 10;
        else if(Delta > 0.02)
            return 5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.04)
            return -8;
        else if(Delta > -0.1)
            return -20;
        else if(Delta > -0.15)
            return -30;
        else if(Delta > -0.2)
            return -40;
        else if(Delta > -0.99)
            return -50;
        else
            return 0;
    } 
    private static Integer getUnemploy_Rate_5Y_Factored_Score(Decimal Delta){
        if(Delta > 0.2)
            return 25;
        else if(Delta > 0.15)
            return 20;
        else if(Delta > 0.1)
            return 15;
        else if(Delta > 0.05)
            return 10;
        else if(Delta > 0.02)
            return 5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.04)
            return -8;
        else if(Delta > -0.1)
            return -20;
        else if(Delta > -0.15)
            return -30;
        else if(Delta > -0.2)
            return -40;
        else if(Delta > -0.99)
            return -50;
        else
            return 0;
    } 
    
    // Total_Population------------------------
    private static Integer getTotal_Population_Factored_Score(Decimal Delta){
        if(Delta > 120000)
            return 50;
        else if(Delta > 100000)
            return 40;
        else if(Delta > 80000)
            return 30;
        else if(Delta > 60000)
            return 20;
        else if(Delta > 40000)
            return 5;
        else if(Delta > 20000)
            return -10;
        else if(Delta > 10000)
            return -25;
        else if(Delta > 5000)
            return -35;
        else if(Delta > 1000)
            return -40;
        else if(Delta > 0)
            return -50;
        else
            return 0;
    } 
    
    private static Integer getTotal_Population_1Y_Factored_Score(Decimal Delta){
        if(Delta > 0.01)
            return 25;
        else if(Delta > 0.08)
            return 20;
        else if(Delta > 0.06)
            return 15;
        else if(Delta > 0.04)
            return 10;
        else if(Delta > 0.02)
            return 5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.04)
            return -8;
        else if(Delta > -0.1)
            return -20;
        else if(Delta > -0.15)
            return -30;
        else if(Delta > -0.2)
            return -40;
        else if(Delta > -0.99)
            return -50;
        else
            return 0;
    } 
    
    private static Integer getTotal_Population_3Y_Factored_Score(Decimal Delta){
        if(Delta > 0.15)
            return 25;
        else if(Delta > 0.1)
            return 25;
        else if(Delta > 0.06)
            return 15;
        else if(Delta > 0.04)
            return 10;
        else if(Delta > 0.02)
            return 5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.04)
            return -8;
        else if(Delta > -0.1)
            return -20;
        else if(Delta > -0.15)
            return -30;
        else if(Delta > -0.2)
            return -40;
        else if(Delta > -0.99)
            return -50;
        else
            return 0;
    } 
    private static Integer getTotal_Population_5Y_Factored_Score(Decimal Delta){
        if(Delta > 0.2)
            return 25;
        else if(Delta > 0.15)
            return 20;
        else if(Delta > 0.1)
            return 15;
        else if(Delta > 0.05)
            return 10;
        else if(Delta > 0.02)
            return 5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.04)
            return -8;
        else if(Delta > -0.1)
            return -20;
        else if(Delta > -0.15)
            return -30;
        else if(Delta > -0.2)
            return -40;
        else if(Delta > -0.99)
            return -50;
        else
            return 0;
    } 
    
    // Median_Rent------------------------
    private static Integer getMedian_Rent_Factored_Score(Decimal Delta){
        if(Delta > 2000)
            return 15;
        else if(Delta > 1500)
            return 10;
        else if(Delta > 1000)
            return 0;
        else if(Delta > 750)
            return -10;
        else if(Delta > 0)
            return -20;
        else
            return 0;
    } 
    
    // Median_Household_Income------------------------
    private static Integer getMedian_Household_Income_Factored_Score(Decimal Delta){
        if(Delta > 200000)
            return 50;
        else if(Delta > 180000)
            return 40;
        else if(Delta > 160000)
            return 30;
        else if(Delta > 140000)
            return 20;
        else if(Delta > 120000)
            return 10;
        else if(Delta > 110000)
            return 0;
        else if(Delta > 100000)
            return -10;
        else if(Delta > 80000)
            return -20;
        else if(Delta > 60000)
            return -30;
        else if(Delta > 40000)
            return -40;
        else if(Delta > 20000)
            return -50;
        else
            return 0;
    } 
    
    // Median_Home_Value------------------------
    private static Integer getMedian_Home_Value_Factored_Score(Decimal Delta){
        if(Delta > 1000000)
            return 20;
        else if(Delta > 750000)
            return 15;
        else if(Delta > 500000)
            return 0;
        else if(Delta > 250000)
            return -10;
        else if(Delta > 0)
            return -20;
        else
            return 0;
    } 
    
    private static Integer getMedian_Home_Value_1Y_Factored_Score(Decimal Delta){
        if(Delta > 0.25)
            return 25;
        else if(Delta > 0.2)
            return 20;
        else if(Delta > 0.15)
            return 15;
        else if(Delta > 0.1)
            return 10;
        else if(Delta > 0.05)
            return 5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.05)
            return -8;
        else if(Delta > -0.1)
            return -15;
        else if(Delta > -0.15)
            return -20;
        else if(Delta > -0.2)
            return -30;
        else if(Delta > -0.99)
            return -50;
        else
            return 0;
    } 
    
    private static Integer getMedian_Home_Value_3Y_Factored_Score(Decimal Delta){
        if(Delta > 0.35)
            return 25;
        else if(Delta > 0.25)
            return 25;
        else if(Delta > 0.15)
            return 10;
        else if(Delta > 0.1)
            return 5;
        else if(Delta > 0.05)
            return 2;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.05)
            return -5;
        else if(Delta > -0.1)
            return -15;
        else if(Delta > -0.15)
            return -20;
        else if(Delta > -0.2)
            return -30;
        else if(Delta > -0.99)
            return -50;
        else
            return 0;
    } 
    private static Integer getMedian_Home_Value_5Y_Factored_Score(Decimal Delta){
        if(Delta > 0.4)
            return 25;
        else if(Delta > 0.3)
            return 25;
        else if(Delta > 0.2)
            return 10;
        else if(Delta > 0.1)
            return 5;
        else if(Delta > 0.05)
            return 2;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.05)
            return -5;
        else if(Delta > -0.1)
            return -15;
        else if(Delta > -0.15)
            return -20;
        else if(Delta > -0.2)
            return -30;
        else if(Delta > -0.99)
            return -50;
        else
            return 0;
    } 
    
    // Grade_Weather------------------------
    private static Integer getGrade_Weather_5Y_Factored_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
    
    // Grade_Public_Schools------------------------
    private static Integer getGrade_Public_School_5Y_Factored_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
      
    // Grade_Overall------------------------
    private static Integer getGrade_Overall_5Y_Factored_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
      
    // Grade_Health_And_Fitness------------------------
    private static Integer getHealth_And_Fitness_5Y_Factored_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
      
    // Grade_Access_To_Restaurants------------------------
    private static Integer getAccess_To_Restaurants_5Y_Factored_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
      
    // Grade_Access_To_Outdoor_Activities------------------------
    private static Integer getOutdoor_Activities_5Y_Factored_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
      
    // Grade_Access_To_Nightlife_Score------------------------
    private static Integer getAccess_To_Nightlife_5Y_Factored_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
      
    // Grade_Access_To_Coffee_Shops------------------------
    private static Integer getGrade_Access_To_Coffee_Shops_5Y_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
      
    // Grade_Access_To_Bars_Factored_Score------------------------
    private static Integer getGrade_Access_To_Bars_5_Y_Factored_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
        
    // Edu_Breakdown_Degree_Doctorate__c------------------------
    private static Integer getEdu_Breakdown_Degree_Doctorate_5Y_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
    
    private static Integer getEdu_Breakdown_Degree_Doctorate_Score(Decimal record){
        if(record > 0.4)
            return 40;
        else if(record > 0.3)
            return 30;
        else if(record > 0.2)
            return 25;
        else if(record > 0.1)
            return 20;
        else if(record > 0.05)
            return 10;
        else if(record > 0.03)
            return -5;
        else if(record > 0.02)
            return -10;
        else if(record > 0)
            return -20;
        else
            return 0;
    }
    
	// Edu_Breakdown_Degree_Masters------------------------
    private static Integer getEdu_Breakdown_Degree_Masters_5Y_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
    
    private static Integer getEdu_Breakdown_Degree_Masters_Score(Decimal record){
        if(record > 0.5)
            return 40;
        else if(record > 0.4)
            return 30;
        else if(record > 0.3)
            return 25;
        else if(record > 0.2)
            return 20;
        else if(record > 0.1)
            return 10;
        else if(record > 0.05)
            return -5;
        else if(record > 0.02)
            return -10;
        else if(record > 0)
            return -20;
        else
            return 0;
    }
        
    // Edu_Breakdown_Degree_Bachelors------------------------
    private static Integer getEdu_Breakdown_Degree_Bachelors_5Y_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
    
    private static Integer getEdu_Breakdown_Degree_Bachelors_Score(Decimal record){
        if(record > 0.8)
            return 40;
        else if(record > 0.6)
            return 30;
        else if(record > 0.4)
            return 25;
        else if(record > 0.3)
            return 20;
        else if(record > 0.2)
            return 10;
        else if(record > 0.1)
            return 0;
        else if(record > 0.05)
            return -10;
        else if(record > 0)
            return -20;
        else
            return 0;
    }
    
    // Diversity_Breakdown_White------------------------
    private static Integer getDiversity_Breakdown_White_5Y_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
    
    private static Integer getDiversity_Breakdown_White_Score(Decimal record){
        if(record > 0.8)
            return 40;
        else if(record > 0.6)
            return 30;
        else if(record > 0.4)
            return 25;
        else if(record > 0.3)
            return 20;
        else if(record > 0.2)
            return 10;
        else if(record > 0.1)
            return 0;
        else if(record > 0.05)
            return -10;
        else if(record > 0)
            return -20;
        else
            return 0;
    }
    
    // Diversity_Breakdown_Hispanic------------------------
    private static Integer getDiversity_Breakdown_Hispanic_5Y_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
    
    private static Integer getDiversity_Breakdown_Hispanic_Score(Decimal record){
        if(record > 0.8)
            return -40;
        else if(record > 0.6)
            return -30;
        else if(record > 0.4)
            return -25;
        else if(record > 0.3)
            return -20;
        else if(record > 0.2)
            return -10;
        else if(record > 0.1)
            return 0;
        else if(record > 0.05)
            return 10;
        else if(record > 0)
            return 20;
        else
            return 0;
    }
    
    // Diversity_Breakdown_African_American------------------------
    private static Integer getDiversity_Breakdown_African_5Y_Delta_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
    
    private static Integer getDiversity_Breakdown_African_Score(Decimal record){
        if(record > 0.8)
            return -40;
        else if(record > 0.6)
            return -30;
        else if(record > 0.4)
            return -25;
        else if(record > 0.3)
            return -20;
        else if(record > 0.2)
            return -10;
        else if(record > 0.1)
            return 0;
        else if(record > 0.05)
            return 10;
        else if(record > 0)
            return 20;
        else
            return 0;
    }
    
    // over 90------------------------
    private static Integer getCommute_Time_Over_90_5Y_Delta_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
    
    private static Integer getCommute_Time_Over_90_Score(Decimal record){
        if(record > 0.25)
            return -30;
        else if(record > 0.2)
            return -25;
        else if(record > 0.15)
            return -20;
        else if(record > 0.1)
            return -10;
        else if(record > 0.05)
            return 0;
        else if(record > 0.04)
            return 5;
        else if(record > 0.03)
            return 10;
        else if(record > 0.02)
            return 15;
        else if(record > 0.01)
            return 18;
        else if(record > 0)
            return 30;
        else
            return 0;
    }
    
    // 60-89------------------------
    private static Integer getCommute_Time_60_89_Delta_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
    
    private static Integer getCommute_Time_60_89_Score(Decimal record){
        if(record > 0.3)
            return -30;
        else if(record > 0.2)
            return -25;
        else if(record > 0.15)
            return -20;
        else if(record > 0.1)
            return -10;
        else if(record > 0.08)
            return 0;
        else if(record > 0.06)
            return 5;
        else if(record > 0.04)
            return 10;
        else if(record > 0.03)
            return 15;
        else if(record > 0.02)
            return 20;
        else if(record > 0.01)
            return 25;
        else if(record > 0)
            return 30;
        else
            return 0;
    }
    
    // 45-59------------------------
    private static Integer getCommute_Time_45_59_Delta_Score(Decimal Delta){
        if(Delta > 2)
            return -25;
        else if(Delta > 1.5)
            return -20;
        else if(Delta > 1)
            return -15;
        else if(Delta > 0.5)
            return -10;
        else if(Delta > 0.25)
            return -5;
        else if(Delta > 0)
            return 0;
        else if(Delta > -0.25)
            return 10;
        else if(Delta > -0.4)
            return 15;
        else if(Delta > -0.6)
            return 20;
        else if(Delta > -0.8)
            return 25;
        else if(Delta > -1)
            return 30;
        else
            return 0;
    } 
    
    private static Integer getCommute_Time_45_59_Score(Decimal record){
        if(record > 0.4)
            return -30;
        else if(record > 0.3)
            return -25;
        else if(record > 0.25)
            return -20;
        else if(record > 0.2)
            return -10;
        else if(record > 0.15)
            return 0;
        else if(record > 0.1)
            return 5;
        else if(record > 0.08)
            return 10;
        else if(record > 0.06)
            return 15;
        else if(record > 0.04)
            return 20;
        else if(record > 0.02)
            return 25;
        else if(record > 0)
            return 30;
        else
            return 0;
    }
    //

}
