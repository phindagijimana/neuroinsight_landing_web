# NeuroInsight documentation map

One-page index of **canonical** docs. Prefer these links over copying the same prose in multiple repos.

## Naming (read once)

| Layer | Name | Canonical link |
|-------|------|----------------|
| Platform | **NeuroInsight** | [Landing site](https://phindagijimana.github.io/neuroinsight_landing_web/) |
| Workflow | **AutoHS** | [AutoHS GitHub](https://github.com/phindagijimana/AutoHS) |
| Application | **NeuroInsight-AutoHS** (repo: `neuroinsight_local`) | [Releases](https://github.com/phindagijimana/neuroinsight_local/releases) |

Paper readers: [Software from the publication](https://phindagijimana.github.io/neuroinsight_landing_web/#publication) (AutoHS workflow + NeuroInsight-AutoHS app).

## I want to…

| Goal | Start here |
|------|------------|
| Understand the platform | [Landing — About](https://phindagijimana.github.io/neuroinsight_landing_web/#about) |
| Reproduce the Brain Communications method | [Landing — From the publication](https://phindagijimana.github.io/neuroinsight_landing_web/#publication) · [Research page](https://phindagijimana.github.io/neuroinsight_landing_web/research.html) |
| Run **AutoHS** on BIDS data (CLI / HPC) | [AutoHS Read the Docs — quickstart](https://autohs.readthedocs.io/en/latest/quickstart.html) |
| Install **NeuroInsight-AutoHS** (web / Docker / desktop) | [App README](https://github.com/phindagijimana/neuroinsight_local#deployment-options) · [User Guide hub](https://github.com/phindagijimana/neuroinsight_local/blob/master/docs/USER_GUIDE.md) |
| Cite software or the paper | [AutoHS — citation](https://autohs.readthedocs.io/en/latest/citation.html) |
| Licensing (research vs commercial) | App: [LICENSE](https://github.com/phindagijimana/neuroinsight_local/blob/master/LICENSE) · [COMMERCIAL.md](https://github.com/phindagijimana/neuroinsight_local/blob/master/COMMERCIAL.md) · AutoHS: [LICENSE](https://github.com/phindagijimana/AutoHS/blob/main/LICENSE) |
| Independent validation | [AutoHS VALIDATION.md](https://github.com/phindagijimana/AutoHS/blob/main/VALIDATION.md) |
| Fix AutoHS CLI / BIDS errors | [AutoHS troubleshooting (RTD)](https://autohs.readthedocs.io/en/latest/troubleshooting.html) |
| Fix NeuroInsight-AutoHS app / Docker / jobs | [App TROUBLESHOOTING.md](https://github.com/phindagijimana/neuroinsight_local/blob/master/docs/TROUBLESHOOTING.md) |

## Repository roles (no duplicate tutorials)

- **`neuroinsight_landing_web`** — orientation only (platform, paper → software, workflow catalog).
- **`AutoHS`** — science + BIDS App (incoming) CLI; depth on [Read the Docs](https://autohs.readthedocs.io/).
- **`neuroinsight_local`** — NeuroInsight-AutoHS deployment and operations ([USER_GUIDE](https://github.com/phindagijimana/neuroinsight_local/blob/master/docs/USER_GUIDE.md) hub + linked deploy guides).

When updating docs, change **one canonical page** for a topic, then adjust links elsewhere—do not paste full sections into READMEs.
