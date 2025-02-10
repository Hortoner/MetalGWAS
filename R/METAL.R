#' @title 使用METAL软件对GWAS进行meta分析
#'
#' @description 使用METAL软件对全基因组关联研究(GWAS)数据进行META分析，电脑运存小容易运行崩溃。
#'
#' @param GWASfile 向量，包含两个或多个GWAS数据文件的路径，如c("./dat1.txt", "./dat1.txt")。
#' @param SEPARATOR 指定数据文件中列之间的分隔符，默认为"TAB"。
#' @param snp_col 必填，SNP列的名称。
#' @param effect_allele_col 必填，效应等位基因列的名称。
#' @param other_allele_col 必填，次要等位基因列的名称。
#' @param beta_col 必填，β值列的名称。
#' @param se_col 必填，标准误差列的名称。
#' @param pval_col 必填，P值列的名称。
#' @param eaf_col 非必填，效应等位基因频率列的名称；若缺失eaf值，请将设置Average_FREQ = FALSE。
#' @param samplesize_col 必填，样本量列的名称。
#' @param analysis_method "SE"或"samplesize"，SE表示逆方差加权法-IVW，samplesize表示基于样本量加权。
#' @param IVW_mode 逆方差加权法-IVW分析模式，默认随机效应模型 "Multiplicative"，固定效应模型填 "Fixed"。
#' @param Genomic_Control_Correction 逻辑值，是否进行基因组控制校正，默认为TRUE。
#' @param Average_FREQ TRUE或FALSE，是否计算平均频率，默认为TRUE。
#' @param Heterogeneity TRUE或FALSE，是否进行异质性分析，默认为TRUE。
#' @param Sample_Overlap_Correction TRUE或FALSE，是否进行样本重叠校正，默认为TRUE。
#' @param OVERLAP_ZCUTOFF 数值，样本重叠校正的Z截断值，默认为1。
#' @param Filter_MAF 数值，次要等位基因频率过滤值，默认为NULL。
#' @param Filter_N 数值，样本大小过滤值，默认为NULL。
#' @param Filter_SNPs 字符向量，需要过滤的SNP，默认为NULL。
#' @param save_path 分析结果保存路径，默认为"./META_GWAS"。
#' @param save_name 分析结果文件名，默认为"METAANALYSIS"。
#'
#' @return 无返回值，将执行GWAS分析并将结果保存到指定路径。
#'
#' @examples
#'
#'library(MetalGWAS)
#'
#'file1 <- system.file("data/ULCER_METAL_10k.txt", package = "MetalGWAS")
#'
#'file2 <- system.file("data/UC_METAL_10k.txt.", package = "MetalGWAS")
#'
#'METAL(GWASfile = c(file1, file2),
#'      SEPARATOR = "TAB",
#'      snp_col = "SNP",
#'      effect_allele_col = "effect_allele",
#'      other_allele_col = "other_allele",
#'      beta_col = "beta",
#'      se_col = "se",
#'      pval_col = "pval",
#'      eaf_col = "eaf",
#'      samplesize_col = "N",
#'      analysis_method = "SE",
#'      IVW_mode = "Multiplicative",
#'      Genomic_Control_Correction = TRUE,
#'      Average_FREQ = TRUE,
#'      Heterogeneity = TRUE,
#'      Sample_Overlap_Correction = TRUE,
#'      OVERLAP_ZCUTOFF = 1,
#'      Filter_MAF = NULL,
#'      Filter_N = NULL,
#'      Filter_SNPs = NULL,
#'      save_path = "./meta",
#'      save_name = "UC")
#'
#' @export

METAL <- function (GWASfile = c("./dat1.txt", "./dat1.txt"),
                   SEPARATOR = "TAB",
                   snp_col = "SNP",
                   effect_allele_col = "effect_allele",
                   other_allele_col = "other_allele",
                   beta_col = "beta",
                   se_col = "se",
                   pval_col = "pval",
                   eaf_col = "eaf",
                   samplesize_col = "N",
                   analysis_method = "SE",
                   IVW_mode = "Multiplicative",
                   Genomic_Control_Correction = TRUE,
                   Average_FREQ = TRUE,
                   Heterogeneity = TRUE,
                   Sample_Overlap_Correction = TRUE,
                   OVERLAP_ZCUTOFF = 1,
                   Filter_MAF = NULL,
                   Filter_N = NULL,
                   Filter_SNPs = NULL,
                   save_path = "./META_GWAS",
                   save_name = "METAANALYSIS") {

  stopifnot(analysis_method %in% c("samplesize","SE"))
  stopifnot(IVW_mode %in% c("Fixed","Multiplicative","Additive"))
  stopifnot(Average_FREQ %in% c(TRUE,FALSE))
  stopifnot(Genomic_Control_Correction %in% c(TRUE,FALSE))
  stopifnot(Sample_Overlap_Correction %in% c(TRUE,FALSE))
  exe_py <- system.file("soft/METAL_code.Rc", package="MetalGWAS")
  compiler::loadcmp(exe_py,env = environment())
}
