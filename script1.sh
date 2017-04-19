

declare -a arr=("r_0" "r_0.5" "r_0.8" "r_1.05" "r_1.1")
declare -a dis=("0.0" "0.1" "0.2" "0.3" "0.4" "1.0")
declare -a vars=("vars_r_0" "vars_r_0_5" "vars_r_0_8" "vars_1_05" "vars_1_1")


## now loop through the above array
cd DOS_disorder_Weyl_SC;

arraylength=${#arr[@]}

#for (( i=1; i<${arraylength}+1; i++ ));
#do
#echo $i " / " ${arraylength} " : " ${array[$i-1]}
#done


for  (( i=1; i<${arraylength}+1; i++ ));
do
   echo "$i"
     rm -rf ${arr[$i-1]}
     mkdir ${arr[$i-1]}   
     cd ${arr[$i-1]}
     
 
   for j in "${dis[@]}"
   #echo $p


   do
     rm -rf Disorder$j
     mkdir "Disorder$j"
     cp "../${vars[$i-1]}.m"  "Disorder$j"/vars.m
     cp ../Hamiltonian.m ../Add_disorder_to_Hamiltonian.m ../Yi_BDG3.m "Disorder$j"
     cd Disorder$j
    
        sed -i "/U_Disorder=/c\U_Disorder=$j;" vars.m;  
     
      sbatch ../../../run_matlab_job;     
     cd ..
   done
   
cd ..
done
