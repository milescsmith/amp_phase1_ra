#' ---
#' title: "Plotting Figure 2: Krenn inflammatory score and flow cytometry gates 
#' for OA, non-inflamed RA, and non-inflamed RA"
#' author: "Fan Zhang"
#' 
#' date: "2018-03-23"
#' ---
#' 

setwd("/Users/fanzhang/Documents/GitHub/amp_phase1_ra/")

library(ggplot2)
library(reshape2)
library(dplyr)
require(gdata)
library(ggbeeswarm)

source("R/pure_functions.R")
source("R/meta_colors.R")

# Read the 51 post-QC data from postQC_all_samples.xlsx
dat <- read.xls("data/postQC_all_samples.xlsx")
dim(dat)
table(dat$Mahalanobis_20)

# # Load flow cytometry data that collected by Kevin
# flow <- read.xls("data/171215_FACS_data_for_figure.xlsx")
# flow_qc <- flow[which(flow$Sample.ID %in% dat$Patient),]
# dim(flow_qc)
# colnames(flow_qc)[2] <- "Patient"
# 
# dat_all <- merge(dat, flow_qc, by = "Patient")
# dim(dat_all)
# table(dat_all$Case.Control)

dat_all <- dat
dat_all$Mahalanobis_20 <- factor(dat_all$Mahalanobis_20,
                       levels = c('OA','non-inflamed RA', "inflamed RA"),ordered = TRUE)

# ---
# Plot B cells/total live cells by flow
# ---

# dat_median <- dat_all %>% group_by(Mahalanobis_20) %>% summarise(median = median(B.cells))
dat_median <- dat_all %>% group_by(disease_tissue) %>% summarise(median = median(B.cells))

ggplot(data=dat_all, 
       mapping = aes(x=Mahalanobis_20, y=100*B.cells, fill=Mahalanobis_20)
       # mapping = aes(x=disease_tissue, y=100*B.cells, fill=disease_tissue)
       # mapping = aes(x=Disease, y=100*B.cells, fill=Disease)
  ) +
  geom_quasirandom(
    shape = 21, size = 4.5, stroke = 0.35
  ) +
  stat_summary(
    fun.y = median, fun.ymin = median, fun.ymax = median,
    geom = "crossbar", width = 0.8
  ) +
  scale_fill_manual(values = meta_colors$Case.Control) +
  # scale_fill_manual(values = c("white", "grey60", "black")) +
  # scale_fill_manual(values = c("white", "black")) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 3)) + 
  xlab('')+ylab('B cells/Live (%)')+
  theme_bw(base_size = 25) +
  labs(title = "Synovial B cells") +
  theme(
    legend.position = "none",
    axis.ticks = element_blank(), 
    panel.grid = element_blank(),
    axis.text = element_text(size = 25, color = "black"),
    axis.text.x = element_text(angle=35, hjust=1, size=25),
    axis.text.y = element_text(size = 22),
    plot.title = element_text(color="black", size=25)) +
  theme(legend.text=element_text(size=25)) +
  coord_cartesian(ylim = c(0, 75)) 
ggsave(
  file = "flow_bcells_boxplot_inflamed_noninflamed.pdf",
  # file = "flow_bcells_boxplot_arthro_biopsy.pdf",
  # file = "flow_bcells_boxplot_OA_RA.pdf",
  width = 4.5, height = 6.5
)


t.test(dat_all$B.cells[which(dat_all$Mahalanobis_20 == "inflamed RA")],
       dat_all$B.cells[which(dat_all$Mahalanobis_20 == "OA")],
       alternative ="greater")


# ---
# Plot T cells/total live cells by flow
# ---
# dat_median <- dat_all %>% group_by(Mahalanobis_20) %>% summarise(median = median(T.cells))
dat_median <- dat_all %>% group_by(disease_tissue) %>% summarise(median = median(T.cells))

ggplot(data=dat_all, 
       mapping = aes(x=Mahalanobis_20, y=100*T.cells, fill=Mahalanobis_20)
       # mapping = aes(x=Disease, y=100*T.cells, fill=Disease)
       ) +
  geom_quasirandom(
    shape = 21, size = 4.5, stroke = 0.35
  ) +
  stat_summary(
    fun.y = median, fun.ymin = median, fun.ymax = median,
    geom = "crossbar", width = 0.8
  ) +
  scale_fill_manual(values = meta_colors$Case.Control) +
  # scale_fill_manual(values = c("white", "grey60", "black")) +
  # scale_fill_manual(values = c("white", "black")) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 3)) + 
  xlab('')+ylab('T cells/Live (%)')+
  theme_bw(base_size = 25) +
  labs(title = "Synovial T cells") +
  theme(
    legend.position = "none",
    axis.ticks = element_blank(), 
    panel.grid = element_blank(),
    axis.text = element_text(size = 25, color = "black"),
    axis.text.x = element_text(angle=35, hjust=1, size=25),
    axis.text.y = element_text(size = 25),
    plot.title = element_text(color="black", size=25)) +
  theme(legend.text=element_text(size=25)) +
  coord_cartesian(ylim = c(0, 75)) 
ggsave(
  # file = "flow_tcells_boxplot_inflamed_noninflamed.pdf",
  file = "flow_tcells_boxplot_arthro_biopsy.pdf",
  # file = "flow_tcells_boxplot_OA_RA.pdf",
  width = 4.5, height = 6.5
)


t.test(dat_all$T.cells[which(dat_all$Mahalanobis_20 == "inflamed RA")],
       dat_all$T.cells[which(dat_all$Mahalanobis_20 == "OA")],
       alternative ="greater")


# ---
# Plot monocytes/total live cells by flow
# ---
# dat_median <- dat_all %>% group_by(Mahalanobis_20) %>% summarise(median = median(Monocytes))
dat_median <- dat_all %>% group_by(disease_tissue) %>% summarise(median = median(Monocytes))

ggplot(data=dat_all, 
       mapping = aes(x=Mahalanobis_20, y=100*Monocytes, fill=Mahalanobis_20)
       # mapping = aes(x=disease_tissue, y=100*Monocytes, fill=disease_tissue)
       # mapping = aes(x=Disease, y=100*Monocytes, fill=Disease)
       ) +
  geom_quasirandom(
    shape = 21, size = 4.5, stroke = 0.35
  ) +
  stat_summary(
    fun.y = median, fun.ymin = median, fun.ymax = median,
    geom = "crossbar", width = 0.8
  ) +
  scale_fill_manual(values = meta_colors$Case.Control) +
  # scale_fill_manual(values = meta_colors$tissue_type) +
  # scale_fill_manual(values = c("white", "grey60", "black")) +
  # scale_fill_manual(values = c("white", "black")) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 3)) + 
  xlab('')+ylab('Monocytes/Live (%)')+
  theme_bw(base_size = 25) +
  labs(title = "Synovial monocytes") +
  theme(
    legend.position = "none",
    axis.ticks = element_blank(), 
    panel.grid = element_blank(),
    axis.text = element_text(size = 25, color = "black"),
    axis.text.x = element_text(angle=35, hjust=1, size=25),
    axis.text.y = element_text(size = 25),
    plot.title = element_text(color="black", size=25)) +
  theme(legend.text=element_text(size=25)) 
  # coord_cartesian(ylim = c(0, 60)) 
ggsave(
  file = "flow_mono_boxplot_inflamed_noninflamed.pdf",
  # file = "flow_mono_boxplot_arthro_biopsy.pdf",
  # file = "flow_monocytes_boxplot_OA_RA.pdf",
  width = 4.5, height = 6.5
)

t.test(dat_all$Monocytes[which(dat_all$Mahalanobis_20 == "inflamed RA")],
       dat_all$Monocytes[which(dat_all$Mahalanobis_20 == "OA")],
       alternative ="greater")


# ---
# Plot lymphocytes/total live cells by flow
# ---
# dat_median <- dat_all %>% group_by(Mahalanobis_20) %>% summarise(median = median(Lymphocytes.Live))
dat_median <- dat_all %>% group_by(disease_tissue) %>% summarise(median = median(Lymphocytes.Live))

ggplot(data=dat_all, 
       # mapping = aes(x=Mahalanobis_20, y=100*Lymphocytes.Live, fill=Mahalanobis_20)
       mapping = aes(x=disease_tissue, y=100*Lymphocytes.Live, fill=disease_tissue)
       ) +
  geom_quasirandom(
    shape = 21, size = 4, stroke = 0.2
  ) +
  stat_summary(
    fun.y = median, fun.ymin = median, fun.ymax = median,
    geom = "crossbar", width = 0.8
  ) +
  # scale_fill_manual(values = meta_colors$Case.Control) +
  scale_fill_manual(values = meta_colors$tissue_type) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 3)) + 
  xlab('')+ylab('% of synovial cells')+
  theme_bw(base_size = 20) +
  labs(title = "Synovial lymphocytes") +
  theme(
    legend.position = "none",
    axis.ticks = element_blank(), 
    panel.grid = element_blank(),
    axis.text = element_text(size = 20, color = "black"),
    axis.text.x = element_text(angle=35, hjust=1, size=20),
    axis.text.y = element_text(size = 20),
    plot.title = element_text(color="black", size=22)) +
  theme(legend.text=element_text(size=20)) 
  # coord_cartesian(ylim = c(0, 60)) 
ggsave(
  # file = "flow_lymphocyes_boxplot_inflamed_noninflamed.pdf",
  file = "flow_lymphocyes_boxplot_arthro_biopsy.pdf",
  width = 4, height = 6
)


# ---
# Plot Lymphcytes.Live vs Monocytes without using inflamed/non-inflamed color
# ---
ggplot(data=dat_all, 
       mapping = aes(x=Lymphocytes.Live*100, y=Monocytes*100, fill = disease_tissue)) +
  geom_point(
    size = 4, shape = 21, stroke = 0.5
  ) +
  scale_fill_manual(values = c("white", "grey60", "black")) +
  # scale_shape_manual(
  #   values = c(1, 0, 15)
  # ) +
  xlab('Lymphocytes/Live (%)')+ylab('Monocytes/Live (%)')+
  theme_bw(base_size = 20) +
  labs(title = "") +
  theme(
    # legend.position = "none",
    axis.ticks = element_blank(), 
    panel.grid = element_blank(),
    axis.text = element_text(size = 20, color = "black"),
    axis.text.x = element_text(size=20),
    axis.text.y = element_text(size = 20),
    plot.title = element_text(color="black", size=22)) +
  theme(legend.text=element_text(size=20)) 
ggsave(
  file = "lym_mono_arthro_bx.pdf",
  width = 7, height = 5
)

# Plot Mahalanobis distance sqrt(20) = 4.5
dat_all$Mahalanobis <- sqrt(dat_all$Mahalanobis)

ggplot(
  data=dat_all,
  aes(x=T.cells*100, y= Mahalanobis, fill = Mahalanobis_20)
  ) +
  geom_point(
    size = 3.7, shape = 21, stroke = 0.5
  ) +
  geom_hline(yintercept = sqrt(20), linetype = "dashed") +
  facet_grid(disease_tissue ~ ., scales = "free", space = "free_x") +
  scale_fill_manual(values = meta_colors$Case.Control) +
  theme_bw(base_size = 20) +
  labs(title = "") +
  xlab('Monocytes') +
  theme(
    # legend.position = "none",
    axis.ticks = element_blank(), 
    panel.grid = element_blank(),
    axis.text = element_text(size = 20, color = "black"),
    axis.text.x = element_text(size=20),
    axis.text.y = element_text(size = 20),
    plot.title = element_text(color="black", size=22)) +
  theme(legend.text=element_text(size=20)) +
  coord_cartesian(
    # xlim = c(0, 70), 
    ylim = c(0, 20)
    )
ggsave(
  file = "maha_Monocytes.pdf",
  width = 7, height = 6
)



# ---------------
# Remove the n/a value patients for plotting Krenn score and Krenn lining
dat_kren <- dat_all[-which(dat_all$Krenn.Score.Inflammation == "n/a"),]
dat_kren <- dat_kren[-which(dat_kren$Krenn.Score.Lining == "n/a"),]
dim(dat_kren)

dat_kren$Krenn.Score.Inflammation <- as.numeric(as.character(dat_kren$Krenn.Score.Inflammation))
dat_kren$Krenn.Score.Lining <- as.numeric(as.character(dat_kren$Krenn.Score.Lining))

t.test(dat_kren$Krenn.Score.Inflammation[which(dat_kren$Mahalanobis_20 == "inflamed RA")],
       dat_kren$Krenn.Score.Inflammation[which(dat_kren$Mahalanobis_20 == "non-inflamed RA")],
       alternative ="greater")
# p-value = 0.0016

t.test(dat_kren$Krenn.Score.Inflammation[which(dat_kren$Mahalanobis_20 == "inflamed RA")],
       dat_kren$Krenn.Score.Inflammation[which(dat_kren$Mahalanobis_20 == "OA")],
       alternative ="greater")
# p-value = 0.0040


t.test(dat_kren$Krenn.Score.Inflammation[which(dat_kren$Mahalanobis_20 == "inflamed RA")],
       dat_kren$Krenn.Score.Inflammation[which(dat_kren$Mahalanobis_20 %in% c("OA", "on-inflamed RA"))],
       alternative ="greater")
# p-value = 0.0040

# Symbol meaning
# ns P > 0.05
#
# *   P ≤ 0.05
# 
# **  P ≤ 0.01
# 
# *** P ≤ 0.001
# 
# ****  P ≤ 0.0001 (For the last two choices only)

# ---
# Plot Krenn inflammatory score
# ---
dat_median <- dat_kren %>% group_by(Mahalanobis_20) %>% summarise(median = median(Krenn.Score.Inflammation))

ggplot(data=dat_kren, 
       mapping = aes(x=Mahalanobis_20, y=Krenn.Score.Inflammation, fill=Mahalanobis_20)) +
  geom_quasirandom(
    shape = 21, size = 4.5, stroke = 0.35
  ) +
  stat_summary(
    fun.y = median, fun.ymin = median, fun.ymax = median,
    geom = "crossbar", width = 0.8
  ) +
  scale_fill_manual(values = meta_colors$Case.Control) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 3)) + 
  xlab('')+ylab('Krenn score')+
  theme_bw(base_size = 25) +
  labs(title = "Inflammatory infiltrate") +
  theme(
    legend.position = "none",
    axis.ticks = element_blank(), 
    panel.grid = element_blank(),
    axis.text = element_text(size = 25, color = "black"),
    axis.text.x = element_text(angle=35, hjust=1, size=25),
    axis.text.y = element_text(size = 25),
    plot.title = element_text(color="black", size=25)) +
  theme(legend.text=element_text(size=25)) +
  coord_cartesian(ylim = c(0, 3.5)) 
ggsave(
  file = "krenn_boxplot_inflamed_noninflamed.pdf",
  width = 4.5, height = 6.5
)

# ---
# Plot Krenn lining 
# ---
dat_median <- dat_kren %>% group_by(Mahalanobis_20) %>% summarise(median = median(Krenn.Score.Lining))

ggplot(data=dat_kren, 
       mapping = aes(x=Mahalanobis_20, y=Krenn.Score.Lining, fill=Mahalanobis_20)) +
  geom_quasirandom(
    shape = 21, size = 4.5, stroke = 0.35
  ) +
  stat_summary(
    fun.y = median, fun.ymin = median, fun.ymax = median,
    geom = "crossbar", width = 0.8
  ) +
  scale_fill_manual(values = meta_colors$Case.Control) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 3)) + 
  xlab('')+ylab('Krenn lining score')+
  theme_bw(base_size = 25) +
  labs(title = "Lining cell layer") +
  theme(
    legend.position = "none",
    axis.ticks = element_blank(), 
    panel.grid = element_blank(),
    axis.text = element_text(size = 25, color = "black"),
    axis.text.x = element_text(angle=35, hjust=1, size=25),
    axis.text.y = element_text(size = 25),
    plot.title = element_text(color="black", size=25)) +
  theme(legend.text=element_text(size=25)) 
ggsave(
  file = "lining_krenn_boxplot_inflamed_noninflamed.pdf",
  width = 4.5, height = 6.5
)


# ---
# Krenn score vs lymphocyte plot
# ---

# Spearman correlation
cor(dat_kren$Krenn.Score.Inflammation, dat_kren$Lymphocytes.Live, method = "spearman")

fit <- lm(Krenn.Score.Inflammation ~ Lymphocytes.Live, data = dat_kren)
summary(fit)
summary(fit)$adj.r.squared
summary(fit)$r.squared
summary(fit)$coefficients[2,"Pr(>|t|)"]

fit$model$Mahalanobis_20 <- dat_kren$Mahalanobis_20

# Put the P-value and R-square in the right lower corner
d1 <- paste("P", "==", "7E-05", sep="") 
d2 <- paste("R","^","2", "==", round(summary(fit)$r.squared, 3), sep="") 
ggplot(
  fit$model,
  aes(
    x=Krenn.Score.Inflammation,
    y=Lymphocytes.Live* 100,
    fill = Mahalanobis_20
    )
  ) +
  geom_point(
    shape=21, size = 4.5, stroke = 0.35
  ) +
  scale_fill_manual(values = meta_colors$Case.Control) +
  ## if we wanted the points coloured, but not separate lines there are two
  ## options---force stat_smooth() to have one group
  geom_smooth(aes(group = 1), method = "lm", formula = y ~ x, # se = FALSE,
               size = 1.5, linetype="dashed",
              col= "darkgrey", fill="lightgrey") +
  # geom_text(
  #   # aes(4.25,1), label = as.character(d1), parse = TRUE, size=14
  #   aes(2.5,13.9), label = as.character(d1), parse = TRUE, size=17
  # ) +
  # geom_text(
  #   # aes(4.33,0.5), label = as.character(d2), parse = TRUE, size=14
  #   aes(2.45,8), label = as.character(d2), parse = TRUE, size=17
  # ) +
  xlab('Krenn inflammatory score')+ylab('Lymphocyte abundance\n(% of synovial cells)')+
  theme_bw(base_size = 20) +
  theme(
    legend.position = "none",
    axis.ticks = element_blank(), 
    panel.grid = element_blank(),
    axis.text = element_text(size = 20, color = "black"),
    axis.text.x = element_text(size=20),
    axis.text.y = element_text(size = 20)) +
  theme(legend.text=element_text(size=20))
ggsave(file = paste("krenn_lym_inflamed_noninflamed", ".pdf", sep = ""), 
       width = 4.5, height = 4)
dev.off()


# Plot proportion of B cells, CD4 T cells, CD8 T cells, endothelial cells,
# fibroblasts, monocytes, and other cells for three disease cohorts.

# Have to remove 300-0512 since we don't have flow of fibroblast and endothelial cells
dat_all <- dat_all[-which(dat_all$Patient == "300-0512"),]
dat_all$Endothelial <- as.numeric(as.character(dat_all$Endothelial))
dat_all$Fibroblasts <- as.numeric(as.character(dat_all$Fibroblasts))
dat_all$Other <- as.numeric(as.character(dat_all$Other))

bcell_median <- dat_all %>% group_by(Mahalanobis_20) %>% summarise(median = median(B.cells.y))
cd4_median <- dat_all %>% group_by(Mahalanobis_20) %>% summarise(median = median(CD4.T.cells.y))
cd8_median <- dat_all %>% group_by(Mahalanobis_20) %>% summarise(median = median(CD8.T.cells.))
endo_median <- dat_all %>% group_by(Mahalanobis_20) %>% summarise(median = median(Endothelial))
fibro_median <- dat_all %>% group_by(Mahalanobis_20) %>% summarise(median = median(Fibroblasts))
mono_median <- dat_all %>% group_by(Mahalanobis_20) %>% summarise(median = median(Monocytes.y))
other_median <- dat_all %>% group_by(Mahalanobis_20) %>% summarise(median = median(Other))

dat_median = data.frame(
  bcell = bcell_median$median,
  cd4 = cd4_median$median ,
  cd8 = cd8_median$median,
  endo = endo_median$median,
  fibro = fibro_median$median,
  mono = mono_median$median,
  other = other_median$median
)
dat_median <- t(dat_median)

dat_percent = data.frame(
  disease = c(rep("inflamed RA", 7), rep("non-inflamed RA", 7), rep("OA", 7)),
  flow_gate = rep(c("B cell", "CD4 T cell", "CD8 T cell", "Endothelial cell", "Fibroblast", "Monocyte", "Other"), 3),
  flow_value = c(dat_median[,1], dat_median[,2], dat_median[,3])  
)


dat_percent$disease <- factor(dat_percent$disease,
                               levels = c('OA','non-inflamed RA', "inflamed RA"),ordered = TRUE)

ggplot(
  data=dat_percent,
  # aes(x=reorder(disease, flow_pro), y= flow_pro, fill = flow_cell)
  aes(x=disease, y= flow_value, fill = flow_gate)
  ) +
  geom_bar(stat="identity", position = "fill") +
  scale_fill_manual("", values = meta_colors$flow) +
  labs(
    x = NULL,
    y = "Abundance of flow\n (% of live cells)"
    # title = ""
  ) +
  theme_bw(base_size = 20) +
  theme(
    axis.ticks = element_blank(), 
    panel.grid = element_blank(),
    axis.text = element_text(size = 20, color = "black"),
    axis.text.x = element_text(angle = 35, hjust = 1),
    axis.text.y = element_text(size = 20),
    legend.key.size = unit(1, 'lines') # adjust the legend size
    )
ggsave(file = paste("barplot_flow_gates_inflamed_noninflamed", ".pdf", sep = ""), width = 5.5, height = 5, dpi = 300)
dev.off()

