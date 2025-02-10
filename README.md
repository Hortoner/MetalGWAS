# MetalGWAS


<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;使用METAL软件对全基因组关联研究(GWAS)数据进行META分析
<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;具体细节，可查看软件官网（仅支持固定效应模型分析）:
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;http://www.sph.umich.edu/csg/abecasis/Metal/
<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gibran Hemani对原始版本进行了修改，使其能够支持随机效应模型分析，详见:
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;https://github.com/explodecomputer/random-metal
<br><br>

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注意：**
<br>
**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、合并较大或者多个GWAS时，请保存计算机有足够的运行内存；**
<br>
**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、在进行meta分析前，确保所有输入GWAS数据具有相同列名，并检查数据完整性，否则会导致分析失败；**
<br>
**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、输入文件的路径不能含有中文、空格或特殊符号；**
<br>
**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、目前该R语言包仅支持Windows与Linux系统。**
<br><br>
**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、安装R包**

```r

#安装remotes包
install.packages("remotes")

#安装MetalGWAS包
remotes::install_github("Hortoner/MetalGWAS")

#加载MetalGWAS包
library(MetalGWAS)


```

<br>

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、加载示例数据**

```r

file1 <- system.file("data/ULCER_METAL_10k.txt", package = "MetalGWAS")

data1 <- data.table::fread(file1)

head(data1)

file2 <- system.file("data/UC_METAL_10k.txt.", package = "MetalGWAS")

data2 <- data.table::fread(file2)

head(data2)

```
<br>

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、进行meta分析**

```r

METAL(GWASfile = c(file1, file2),
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
      save_path = "./meta",
      save_name = "UC")
      
dat_meta <- data.table::fread("./meta/UC1.txt")

head(dat_meta)

```

<br>

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;将返回以下内容：**

  - 固定效应模型：`Effect`（效应值），`StdErr`（标准误差），`pval`（p值）

  - 异质性统计：`Freq1`（效应等位基因频率），`FreqSE`（效应等位基因频率标准误差）,`Direction`（方向），`HetISq`（I平方统计量），`HetChiSq`（Q统计量），`HetDf`（Q统计量自由度），`HetPVal`（异质性的p值），`tausq`（tau平方）；若`Average_FREQ = FALSE`时，则不返回`Freq1`和`FreqSE`。

  - ARE随机效应模型（DerSimonian-Laird估计量）：`EffectARE`（ARE效应值），`StdErrARE`（ARE标准误差），`PvalueARE`（ARE的p值）

  - MRE随机效应模型（效应大小与固定效应值相同，为`Effect`）：`StdErrMRE`（MRE标准误差），`PvalueMRE`（MRE的p值）
<br><br>
**更多Post GWAS内容，请关注微信公众号: 落叶随风的笔记**
**MetalGWAS—R 语言包实现Metal软件进行GWAS-meta分析：
https://mp.weixin.qq.com/s/SepaIUWmwXjCO0bhsgXImA?token=2116575242&lang=zh_CN**
<br><br><br>
