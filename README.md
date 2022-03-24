# Code & Data for "Do Matching Frictions Explain Unemployment? Not in Bad Times"

This repository contains the code and data associated with the article ["Do Matching Frictions Explain Unemployment? Not in Bad Times"](https://www.pascalmichaillat.org/1.html), written by [Pascal Michaillat](https://www.pascalmichaillat.org), and published in the [American Economic Review](https://doi.org/10.1257/aer.102.4.1721) in June 2012.

## Data

The folder `data` contains text files with data from the Bureau of Labor Statistics (BLS). The data describe key labor market variables and are used in the simulations. Each text files contains one time series:

* `CPI-URBAN.txt` - urban consumption price index from BLS
* `CPS-UL.txt` - unemployment level from Current Population Survey (CPS)
* `CPS-UR.txt` - unemployment rate from CPS
* `MSPC-EMP.txt` - employment level from Major Sector Productivity and
Costs (MSPC)
* `MSPC-OUTPUT.txt` - output level from MSPC
* `HELPWANT.txt` - Help Wanted Advertising Index from the Conference
Board
* `JOLTS-JOLNF.txt` - Job-opening level in the nonfarm business sector from
the Job Opening and Labor Turnover Survey (JOLTS)
* `CES-HWAGEPROD.txt` - average hourly earnings of production and  nonsupervisory workers from the Current Employment Survey (CES)

The readme files `CES_README.txt`, `CPI_README.txt`, `CPS_README.txt`, `HELPWANT_README.txt`, `MSPC_README.txt`, and `JOLTS_README.txt` provide details on the data.

## Code

The simulations are conducted with Matlab code.

### Matlab helper scripts and functions

The simulations rely on a number of helper scripts and functions:

* `reduform.m`, `shftrght.m`, `vech.m`, `STEADYLL.m`, `aim_eig.m`, `aimerr.m`, `build_a.m`, `copy_w.m`, `eigsys.m`, `ex_shift.m`, `numshift.m`, `obstruct.m`, `penta2.m`, `LIN_DSGE.m`, `LIN_DSGE_c.m`, `LIN_DSGE_g.m`, `setupsimul.m`, `setupsimul_1600.m`, `setupsimul_c.m`, `setupsimul_g.m`, `setupsimul_robust.m` - solve the loglinear DSGE model with job rationing and matching frictions
* `OLS.m`, `SUMSTAT.m`, `ACF.m`, `AR.m,` `AUTOCORREL.m` - perform statistical analysis
* `MAKEMC.m`, `MCSOLVE.m`, `OBJEULER.m`, `SHOOTING.m`, `SIMULFT.m`, `SOLVESYS.m`, `STEADYGE.m` - solve the nonlinear DSGE model using the Fair-Taylor algorithm
* `QTOW.m`, `QUARTER.m`, `hpfilter.m`, `TECHNO_1600.m`, `TECHNO.m`, `TFP_1964_2009.m`, `W2QUARTER.m`, `data_1964_2009.m`, `bayesdata.m`, `bayesdata1600.m` -  fetch, prepare, and transform data
* `PROD.m`, `FINDTH.m`, `CREATEU.m` - perform useful calculations
* `calibration.m`, `setup.m`, `setup_elasticity.m`, `setup_g.m`, `setup_graph.m`, `setup_MPR.m`, `setup_robust.m`, `setup_robusthigh.m`, `setup_robustlow.m` - calibrate parameters used in simulations (calibrated values are summarized in Table 1 and Table A6)

### Matlab scripts for main-text results

The results of the numerical simulations in the main text are obtained by running the following scripts:

* `diagram_paper.m` - draw the equilibrium diagram for various search-and-matching models; technology and recruiting cost take different values; results presented in Figure 1
* `diagram_elast.m` - compute the elasticity of labor market tightness with respect to recruiting cost in the model with wage rigidity and in the model with job rationing; results are presented in Figure 2
* `irf_rationing.m` - compute the impulse response functions of the loglinear DSGE model with job rationing and matching frictions; results are presented in Figure 3
* `moments_US.m` - compute the moments of key labor market variables using US data for the 1964—2009 period; US data are detrended using a Hoddrick-Prescott (HP) filter with parameter of 10^5; results are presented in Table 2
* `moments.m` - compute the moments of key labor market variables simulated using the loglinear DSGE model with matching frictions and job rationing; repeat the simulation of the model many times to obtain more precise estimates of the simulated moments; report estimated second moments and standard deviation of these estimates; results are presented in Table 3
* `script_FT.m` - solve the nonlinear DSGE model with job rationing and matching frictions, when it is subject to the actual technology shock measured in US data; compare actual unemployment to simulated unemployment; decompose the simulated unemployment series into a frictional and a rationing component; results are presented in Figures 4 and 5

### Matlab scripts for online-appendix results

The results of the numerical simulations in the online appendix are obtained by running the following scripts:

* `irf_c.m`, `irf_robust.m`, `irf_g.m` - compute the impulse response functions of the loglinear DSGE model with job rationing and matching frictions for different calibrations of the recruiting cost, a different specification of recruiting expenses, and gradual wage adjustment; results are reported in Figures A4, A7, and A8
* `moments_c.m`, `moments_robust.m`, `moments_g.m` - compute the moments of key labor market variables simulated using the loglinear DSGE model with job rationing and matching frictions for different calibrations of the recruiting cost, a different specification of recruiting expenses, and gradual wage adjustment; results are reported in Tables A1, A2, and A3
* `decomposition_shocks.m` - decompose actual unemployment into frictional and rationing components using a variety of specifications for the type of shocks in the economy; results are reported in Section A3
* `moments_US_1600.m` - compute the moments of key labor market variables using US data for the 1964—2009 period; US data are detrended using a HP filter with conventional parameter of 1600; results are presented in Table A4
* `script_FT_robusthigh.m`, `script_FT_robustlow.m`, `script_FT_TFP.m` - solve the nonlinear DSGE model with job rationing and matching frictions when it is subject to the actual technology shock measured in US data; these scripts consider three variants from the analysis in the article: high recruiting cost, low recruiting cost, and capacity-adjusted technology series instead of measured technology series; the scripts compare actual unemployment to simulated unemployment and decompose the simulated unemployment series into a frictional and a rationing component; results are reported in Figures A5, A6, and A9
* `compare_HP.m` - run the entire numerical analysis presented in the manuscript for a  HP-filter parameter of 1600 instead of 100,000; results are reported in Section A4.4
* `compare_methods.m` - compare the time series for unemployment and labor market tightness generated by the model with two different numerical solution methods: (i) a series of equilibria in static environments that abstract from aggregate shocks to technology and dynamics of unemployment; and (ii) the exact solution to the nonlinear model, which accounts fully for the dynamics of unemployment and rational expectations of stochastic process of technology and labor market variables; results are presented in Section A5

## Software versions

The results were obtained on a Mac running OS X Snow Leopard with Matlab R2010a.