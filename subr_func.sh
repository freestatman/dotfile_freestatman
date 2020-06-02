module load cluster-setup
#module load R

function subr
{
    #----------------------------------------------------------------------------
    # $1 argument is the R code scode name
    # $2 argument is the name of the job running on the cluster, by default is subr
    # $3 argument is the dependent job ids
    pg_dir=`pwd`;
    er_dir=${pg_dir}/system_files;
    lg_dir=${pg_dir}/system_files;
    if [ $2 ]; then qname=$2;  else qname=subr; fi;
    if [ -e $1 ]; then
        rcode=$1;
        echo "module load R; cd $pg_dir; R CMD BATCH --no-save --no-restore $rcode $lg_dir/$rcode.Rout" | qsub -N $qname -o $er_dir/$rcode.ou -e $er_dir/$rcode.er; # -j y
    else
        echo "$1 not found.";
        echo "$PWD";
    fi
}



function subs
{
    pg_dir=`pwd`
    er_dir=${pg_dir}/system_files
    lg_dir=${pg_dir}/system_files

    #----------------------------------------------------------------------------
    # $1 argument is the R code file name
    # $2 argument is the name of the job running on the cluster, by default is subs
    # $3 argument is the dependent job ids

    if [ $2 ]; then qname=$2;  else qname=subs; fi

    if [ -e $1 ]; then
        scode=$1
        echo "cd $pg_dir; sh $scode > $lg_dir/$scode.log" | qsub -N $qname -e $er_dir/$scode.er -o $er_dir/$scode.ou
    else
        echo "$1 not found."
        echo "$PWD";
    fi
}



#function subsm
#{
#    pg_dir=`pwd`
#    er_dir=${pg_dir}/system_files
#    lg_dir=${pg_dir}/system_files
#
#    #----------------------------------------------------------------------------
#    # $1 argument is the R code file name
#    # $2 argument is the name of the job running on the cluster, by default is subs
#    # $3 argument is the dependent job ids
#
#    if [ $2 ]; then qname=$2;  else qname=subsm; fi
#
#    if [ -e $1 ]; then
#        scode=$1
#        sed "s/\| qsub/\| qsub -W depend=afterok:$depend/g" $1 > $1.tmp
#    else
#        echo "$1 not found."
#        echo "$PWD";
#    fi
#    jobids=`sh $1.tmp`
#    mv -f $1.tmp > ARCHIVED/
#    echo $jobid | sed 's/ /:/g'
#}
#
