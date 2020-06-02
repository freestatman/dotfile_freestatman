`%x%` <- function(v1, v2){

    I <- intersect(v1, v2) # intersect
    L <- setdiff(v1, I)    # only in left vector
    R <- setdiff(v2, I)    # only in right vector
    out <- data.frame(nL = length(L),
                      nI = length(I),
                      nR = length(R))
    return(out)
}

"%||%" <- function(x, y) {
    if (length(x) > 0) x else y
}

"%+%" <- function(x, y) {     # modify `+` to be Concatenate operator for non-numeric objects
    if (all(is.numeric(x) | is.logical(x),
            is.numeric(y) | is.logical(y)
            )) {
        add <- .Primitive("+")
        return(add(x, y))
    } else if (length(x) > 0 & 
               any(is.character(x), is.character(y)) 
               #class(x) %in% c("numeric", "character", "logical") &
               #class(y) %in% c("numeric", "character", "logical", "NULL")
               ) {
        return(paste0(as.character(x), as.character(y)))
    } else stop("input object's class is not supported")
}

"%+%" <- function(x, y) { 
    return(paste0(as.character(x), as.character(y)))
}

#----------------------------------------------------------------------------
# check dups
#----------------------------------------------------------------------------
check_dup_vec <- function(x, verbose=F){

    nuniq    <- length(unique(x))
    dup.val  <- unique(x[duplicated(x)])
    ndup.val <- length(dup.val)

    index.dup <- which(x %in% dup.val)
    ndup     <- length(index.dup)

    uniq.val <- setdiff(unique(x), dup.val)
    nuniq.val <- length(uniq.val)

    if(!verbose) {
        dup.val <- 'if want to see dup val, set verbose=T'
    }
    out <- list(summary=data.frame(ntotal=length(x), nuniq=nuniq,
                                   ndup.val=ndup.val, ndup=ndup, nuniq.val=nuniq.val),
                dup=dup.val)
    return(out)
}

check_dup <- function(dat, by_var=c('USUBJID', 'PARAMCD', 'PARAM'), nhead=NULL, ...){

    if (FALSE) {    # spot check
        dat <- adlb.flow
        by_var <- c('USUBJID', 'PARAMCD', 'PARAM')
        is.expression(.(A))
        is.vector(.(A, B))
        is.character(.(A, B))
        as.character(.(A, B))
        plyr::count
        is.atomic(dat)
    }    # End spot check

    by_var <- as.character(by_var)
    if (is.vector(by_var)) {
        (by_var <- as.character('.( ' %+% paste(by_var, collapse=',') %+% ' )'))
    }else {
        stop('by_var is not accepted.')
    }

    tmp <- plyr::count(dat, eval(parse(text=by_var)) ) %>% dplyr::arrange(-freq) %>% dplyr::filter(freq > 1)

    if (nrow(tmp) == 0) {
        message('No dup records in current categories.')
        return(NULL)
    }


    if (!is.null(nhead)) {
        tmp <- head(tmp, nhead)
    }

    ret <- tmp %>% left_join(dat)
    if (!is.null(nhead)) {
        ret <- head(ret, nhead)
    }
    ret
}

#----------------------------------------------------------------------------
# fmt numbers
#----------------------------------------------------------------------------
fmtNum <- function(obj, fmt, max.length=NULL){
    # obj is a single numeric or character vecter
    # if fmt is a single character, then the same format will apply on all the elements in obj
    # fmt types expected input values: 'C', '1234', '1234.4', 12%, 12.3%, 1.23e04, 1.23E04

    if (is.numeric(obj) & fmt!='C'){
        is.sci.sml <- length(grep('e', fmt)) != 0
        is.sci.big <- length(grep('E', fmt)) != 0
        is.sci <- (is.sci.sml | is.sci.big)
        is.dot <- length(grep('\\.', fmt)) != 0
        is.pct <- length(grep('%', fmt, fixed=T)) != 0
    } else if (fmt == 'C') {
        return(as.character(obj))
    } else {
        stop('input vector obj is not numeric!')
    }

    # default values
    digits <- 0
    fmttyp <- 'f'
    others <- ''

    if (is.pct) {
        (num <- gsub('%', '', fmt, fixed=T))
        (fmt.spt <- unlist(strsplit(num, split='.', fixed=T))[2])
        (digits <- nchar(fmt.spt))
        obj <- obj * 100
        others <- '%%'
    } else if (is.sci) {
        (fmttyp <- ifelse(is.sci.sml, 'e', 'E'))
        (num <- unlist(strsplit(fmt, split=fmttyp))[1])
        if (is.dot) {
            (num.spt <- unlist(strsplit(num, split='\\.')))
            (digits <- nchar(num.spt[2]))
        }else {
            (digits <- 0)
        }
    } else {
        (num <- fmt)
        if (is.dot) {
            (num.spt <- unlist(strsplit(num, split='\\.')))
            (digits <- nchar(num.spt[2]))
        }else {
            (digits <- 0)
        }
    }
    (ret <- sprintf("%" %+% max.length %+% "." %+% digits %+% fmttyp %+% others, obj))
    return(ret)
}

fmtN <- function(x, digits=2, ...){
    sprintf(paste0("%2.",digits,"f"), x)
}

fmtP <- function(x, digits=3)  { # format=='E' for scientific format
    if (length(x) > 1) {
        y1 <- sapply(x, fmtP)
    }else{
        if (abs(x)<0.01 | is.na(x) ){
            if(is.na(x)){
                y <- ""
            }else{
                (y <- sprintf("%6.0e", x))
            }
        }else{
            (y <- sprintf(paste0("%6.",digits,"f"), x))
        }
        y1 <- replace(y, which(y=='NaN'), 'NA')
    }
    return(y1)
}

.fmt.tmp <- function(x, width, digits, format){
    x.new <- formatC(x, width=width, digits=digits, format=format)
    if(nchar(x.new)>width & !is.pct){ # change long numbers to scientific format
        digits <- width - 6
        digits <- ifelse(digits>=0, digits, 0)
        format <- 'E'
        x.new <- formatC(x, width=width, digits=digits, format=format)
    }
    return(x.new)
}

fmtNumDF <- function(obj, fmt){
    # TODO need update to the next version, use fmtNum for now
    # obj is a matrix/data.frame object , fmt is a character vector to specify the desired format for each column.
    # if fmt is a single character, then the same format will apply on all the columns
    options(digits=22)
    tmp.file <- tempfile()
    write.table(obj, file=tmp.file)
    obj.new <- obj <- read.table(tmp.file, stringsAsFactors=F)
    file.remove(tmp.file)

    m <- ncol(obj)
    if(length(fmt)==1) fmt <- rep(fmt, m)
    if(length(fmt)!=m) stop("length of the input format vectro is not equal to ncol(obj)\n")
    for(i in 1:m) {
        if(is.character(obj[,i]) & fmt[i]!= 'C') warning(paste("'C' is expected for the ", i, "th column, no formatting applied", sep=''))
        if(!is.character(obj[,i]) | fmt[i]!='C'){
            is.sci.sml <- length(grep('e', fmt[i])) != 0
            is.sci.big <- length(grep('E', fmt[i])) != 0
            is.sci <- (is.sci.sml | is.sci.big)
            is.dot <- length(grep('\\.', fmt[i])) != 0
            is.pct <- length(grep('%', fmt[i], fixed=T)) != 0
            if(!is.sci & is.dot & !is.pct) { # xx.xxxx
                format <- 'f'
                width <- nchar(fmt[i])
                fmt.spt <- unlist(strsplit(fmt[i], split='.', fixed=T))[2]
                digits <- nchar(fmt.spt)
            }else if(is.sci & is.dot & !is.pct){ #x.xxxex
                format <- ifelse(is.sci.sml, 'e', 'E')
                width <- nchar(fmt[i])
                fmt.spt <- unlist(strsplit(fmt[i], split='.', fixed=T))
                fmt.spt1 <- unlist(strsplit(fmt.spt[2], split=format))[1]
                digits <- nchar(fmt.spt1)
            }else if(!is.dot & !is.pct){ # xxxxx
                format <- 'f'
                width <- nchar(fmt[i])
                digits <- 0
            }else if(is.dot & is.pct){ # xx.xx%
                if(any(obj[,i]>1)) warning('percentage value is larger than 1!') # suppose all percentage <= 100%, if not, will give warning message
                format <- 'f'
                fmt.spt <- unlist(strsplit(fmt[i], split='.', fixed=T))[2] # xx%
                digits <- nchar(fmt.spt) - 1 # minus 1 for % sign
                width <- digits + 2 + 1 # add one character for dot, and 2 character space for two num before decimal point
                obj[,i] <- obj[,i]*100
            }else if(!is.dot & is.pct){ # xx%
                if(any(obj[,i]>1)) warning('percentage value is larger than 1!')
                format <- 'f'
                digits <- 0
                width <- digits + 2 + 1
                obj[,i] <- obj[,i]*100
            }
            if(fmt[i]=='C') {
                obj.new.col <- obj[,i]
            }else if(format=='f') {
                obj.new.col <- unlist(sapply(obj[,i], .fmt.tmp, width=width, digits=digits, format=format))
            }else obj.new.col <- formatC(obj[,i], width=width, digits=digits, format=format)
            obj.new[, i] <- obj.new.col
            if(is.pct) obj.new[, i] <- paste0(obj.new.col, '%')
        }
    }
    return(obj.new)
}

if (FALSE) {    # test fmtNum()
    fmtNum(c(pi, pi), '123.12', max.length=10)
    fmtNum(c(pi, pi), '123.1234%')
    fmtNum(c(pi, pi), '123.1234e01')
    fmtNum(c(pi, 1:4), '123.1234E01', max.length=15)
}    # End 

#----------------------------------------------------------------------------
# read in data from SDD/CLUWE
#----------------------------------------------------------------------------
rm_sas_df_label <<- cnvt_sas_numeric_col <<- function(dat){
    (num.col <- sapply(dat, is.numeric))
    df <- dat %>% as.matrix %>% as.data.frame(stringsAsFactors=FALSE)
    df[, num.col] <- sapply(df[, num.col], as.numeric)

    return(df)
}

read.csv_sas <- function(file, header=TRUE, nrow=-1, comment.char="", stringsAsFactors=FALSE, ...){
    is.sas <- grepl('.sas7bdat$', file, fixed=FALSE)
    is.csv <- grepl('.csv$', file, fixed=FALSE)
    is.rds <- grepl('.rds$', file, fixed=FALSE)

    if(is.rds){
        ot <- readRDS(file)
    }else if(is.sas){
        ot <- haven::read_sas(file) %>% rm_sas_df_label
        if(header & nrow==1){ot <- names(ot)}    }else if (is.csv){
    }else if(is.csv){
        tm <- try(ot <- read.csv(file=file, h=header, nrow=nrow, na=c('NA', '', '.'), stringsAsFactors=stringsAsFactors,, comment.char=comment.char, ...))
        if(class(tm)=='try-error')
            tm <- try(ot <- read.csv(file=file, h=header, nrow=nrow, na=c('NA', '', '.'), stringsAsFactors=stringsAsFactors, fileEncoding="latin1", comment.char=comment.char))
        if(class(tm)=='try-error')
            tm <- try(ot <- read.csv(file=file, h=header, nrow=nrow, na=c('NA', '', '.'), stringsAsFactors=stringsAsFactors, fileEncoding="UTF-8", comment.char=comment.char))
        if(class(tm)=='try-error')
            tm <- try(ot <- readLines(con=file))
    }else{
        ot <- NULL
    }
    return(ot)
}

import_sdd_dat_swa <- function(path.data, infile, sdd='https://sddchippewa.sas.com/webdav/', verbose=FALSE, ...){ #{{{
    if (FALSE) {    # debug
        (my.tempdir <- '~/' %+% (tempdir() %>% strsplit(split='/') %>% unlist %>% tail(1)))
        infile      <- 'dm.sas7bdat'
    }    # End debug
    is.sas <- grepl('.sas7bdat$', infile, fixed=FALSE)
    is.csv <- grepl('.csv$', infile, fixed=FALSE)

    if (!grepl('\\/$', path.data)) { # normalized input path
        path.data <- path.data %+% '/'
    }

    # check/create credentials
    # http://www.cyberciti.biz/faq/wget-command-with-username-password/
    if (!file.exists('~/.wgetrc')) {
        stop('Create your wget credential for SDD \n
             ref: http://www.cyberciti.biz/faq/wget-command-with-username-password/
             ')
    }
    # change root temp dir to personal home dir
    (my.tempdir <- '~/' %+% (tempdir() %>% strsplit(split='/') %>% unlist %>% tail(1)))
    system('mkdir -p -m 700 ' %+% my.tempdir %+% '; cd ' %+% my.tempdir  %+% '; wget ' %+% sdd %+% path.data %+% infile)
    ret <- try( read.csv_sas(file = file.path(my.tempdir, infile)) )

    if (class(ret) == 'try-error' & is.sas) {
        ret <- try( sas7bdat::read.sas7bdat(file.path(my.tempdir, infile)) )
        message('Strings were kept as factors in the returned data.frame.')
    }

    if (class(ret) == 'try-error' & is.sas) {
        message('Both haven and sas7bdat R packages dont work for reading in this sas data.')
        message('The temp sas data has been removed.')
    }

    system('rm -f ' %+% file.path(my.tempdir, infile))
    system('rm -rf ' %+% file.path(my.tempdir))

    if (verbose) {
        'Linux command line: ' %>% message
        'mkdir -p -m 700 ' %+% my.tempdir %+% '; cd ' %+% my.tempdir  %+% '; wget ' %+% sdd %+% path.data %+% infile %>% message
        '' %>% message
        'The following temp file/folder has been removed: ' %+% file.path(my.tempdir, infile) %>% message
    }

    return(ret)
}

import_cluwe_dat_swa <- function(path.data,  
                                 infile,
                                 cluwe='',
                                 verbose=FALSE,
                                 ...){ #{{{
   
    (is.sas <- grepl('.sas7bdat$', infile, fixed=FALSE))
    (is.csv <- grepl('.csv$', infile, fixed=FALSE))

    (userid <- Sys.info()['user'])

    if (!grepl('\\/$', path.data)) { # normalized input path
        path.data <- path.data %+% '/'
    }

    # check/create SSH key
    if (!file.exists('~/.ssh/id_rsa')) {
        stop('Create your SSH key to CLUWE \n
             ref: https://confluence.atlassian.com/bitbucketserver/creating-ssh-keys-776639788.html
             ')
    }
    # change root temp dir to personal home dir
    (my.tempdir <- '~/' %+% (tempdir() %>% strsplit(split='/') %>% unlist %>% tail(1)))

    system('mkdir -p -m 700 ' %+% my.tempdir %+% '; cd ' %+% my.tempdir  %+% 
           ';scp -q ' %+% userid %+% '@' %+% cluwe %+% ':' %+% path.data %+% infile %+% ' ' %+% my.tempdir %+%
           ' 2> /dev/null'
           ) 

    ret <- try( read.csv_sas(file = file.path(my.tempdir, infile)) )

    if (class(ret) == 'try-error' & is.sas) {
        ret <- try( sas7bdat::read.sas7bdat(file.path(my.tempdir, infile)) )
        message('Strings were kept as factors in the returned data.frame.')
    }

    if (class(ret) == 'try-error' & is.sas) {
        message('Both haven and sas7bdat R packages dont work for reading in this sas data.')
        message('The temp sas data has been removed.')
    }

    system('rm -f ' %+% file.path(my.tempdir, infile))
    system('rm -rf ' %+% file.path(my.tempdir))

    if (verbose) {
        'Linux command line: ' %>% message
        'mkdir -p -m 700 ' %+% my.tempdir %+% '; cd ' %+% my.tempdir  %+% ';scp ' %+% userid %+% '@' %+% cluwe %+% ':' %+% path.data %+% infile %+% ' ' %+% my.tempdir %+% ' 2> /dev/null' %>% message
        '' %>% message
        'The following temp file/folder has been removed: ' %+% file.path(my.tempdir, infile) %>% message
    }

    return(ret)
}

#----------------------------------------------------------------------------
# cat the expression and its result
#----------------------------------------------------------------------------
cat.exp <- function(x, start = "\n----", sep2 = ifelse(Print, "\n", ": "), end = "\n", Print = is.na(match(class(eval(x)), c("integer", "numeric", "character")))) {
    cat(start, deparse(substitute(x)), sep2)
    if (!Print)
        cat(eval(x), end) else print(eval(x))
}

