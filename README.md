# Snakemake workflow: ASTRA
[![Snakemake](https://img.shields.io/badge/snakemake-≥8.10.0-brightgreen.svg)](https://snakemake.bitbucket.io)

ASTRA (Advanced Snakemake Pipeline for Thorough Variant Analysis) performs 
Variant Calling (with [DeepVariant](https://github.com/google/deepvariant)) and 
Variant Annotation (with [VEP](https://grch37.ensembl.org/info/docs/tools/vep/index.html))
starting from tumor BAM files.
ASTRA is part of the Snakemake-based pipelines collection [solida-core](https://github.com/solida-core) 
developed and manteined at [CRS4](https://www.crs4.it). 
<p align="center">
<img align="center" src="https://www.crs4.it/wp-content/uploads/2020/11/CRS4-1.jpg" width="200" height="80" alt="www.crs4.it"/>
</p>

## Authors

* Rossano Atzeni ([@ratzeni](https://github.com/ratzeni))
* Riccardo Berutti ([@berutti](https://github.com/berutti))

## Usage

The usage of this workflow is described in the 
[Snakemake Workflow Catalog](https://snakemake.github.io/snakemake-workflow-catalog?usage=solida-core/astra).

If you use this workflow in a paper, 
don't forget to give credits to the authors by citing the URL of this (original) repository and its DOI (see above).

## Quick Start

### Creating the Conda Environment
To create a virtual environment, use the following command:

```commandline
mamba create -c bioconda -c conda-forge --name snakemake snakemake=8.25 apptainer=1.3.0 snakedeploy
```

Activate the environment with:
```commandline
conda activate snakemake
```

### Installation of Optional Prerequisites

The following prerequisites are optional and may be installed based on your workflow requirements:

```bash
mamba install snakemake-executor-plugin-drmaa=0.1.5  # Optional: For DRMAA cluster execution. Replace with your preferred Snakemake executor plugin (see: https://snakemake.github.io/snakemake-plugin-catalog/plugins/executor/).
mamba install yq=3.4.3  # Optional: Required only if you plan to use the launcher `run.astra.sh`.
```

#### Notes:
- **Snakemake Executor Plugins**: The `snakemake-executor-plugin-drmaa` plugin is an example for DRMAA cluster execution. You can replace it with another executor plugin of your choice. See the [Snakemake Plugin Catalog](https://snakemake.github.io/snakemake-plugin-catalog/plugins/executor/) for available options.
- **`yq`**: This tool is needed only if you plan to use the `run.astra.sh` launcher script, which simplifies execution and configuration.

### Deployment of Astra
Deploy the pipeline by specifying an output directory `my_work_dir` and a pipeline tag or branch:

```bash
snakedeploy deploy-workflow https://github.com/solida-core/astra \
                            /path/to/my_work_dir \
                            --branch master  # or use --tag <version>
```

### Running Astra
Before running the pipeline, ensure that you edit the configuration files located in the `./config/` directory:

- `config.yaml`: Main configuration file for setting pipeline parameters.
- `samples.tsv`: A table listing the samples included in the analysis.
- `units.tsv`: Details about the technical units associated with each sample.
- `reheader.tsv`: Optional file for reheadering sample identifiers.

Refer to the [Configuration Details](./config/README.md) section for a comprehensive guide on editing these files.

Once the configuration files are correctly set up, navigate to the deployed pipeline directory and execute the pipeline with:

```bash
snakemake --use-conda -p --cores all
```
### Generating a Report
To create a comprehensive analysis report, use the command:

```bash
snakemake --report report.zip --cores all
```
