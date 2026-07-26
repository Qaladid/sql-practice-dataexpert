# Darusalam Hospital Analytics Pipeline

> End-to-end data engineering pipeline for Darusalam Pharmaceuticals & Medical Center — a two-branch hospital in Kenya. Transforms raw monthly Excel records into a self-hosted business intelligence dashboard powered by PostgreSQL, dbt, and Metabase.

---

## Overview

Darusalam Hospital operates two branches — **Darusalam I** and **Darusalam II** — each running a pharmacy and clinic. The accountant produces a monthly Excel file per branch containing daily sales, supplier purchases, and a monthly P&L summary.

This pipeline automates the full journey from raw Excel to actionable KPI dashboards:

```
Excel Files → Python Cleaning → PostgreSQL → dbt Transformations → Metabase Dashboard
```

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        SOURCE LAYER                         │
│              Monthly Excel Files (Accountant)               │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                      INGESTION LAYER                        │
│              darusalam_pipeline.py (Python)                 │
│         Cleans, validates, and outputs CSV files            │
│              Organized by month: output/MONTH/              │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                       STORAGE LAYER                         │
│              PostgreSQL (Docker Container)                  │
│   raw_daily_sales │ raw_purchases │ raw_monthly_summary     │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                   TRANSFORMATION LAYER                      │
│                    dbt Core (SQL Models)                    │
│  Staging Views → Mart Tables (5 KPI models)                 │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                    CONSUMPTION LAYER                        │
│              Metabase (Docker Container)                    │
│         Self-hosted dashboard at localhost:3000             │
└─────────────────────────────────────────────────────────────┘
```

---

## Project Structure

```
darusalam-hospital/
├── .env                          # Database credentials (not committed)
├── .gitignore
├── docker-compose.yml            # PostgreSQL + Metabase containers
├── darusalam_pipeline.py         # Excel cleaning & CSV generation
├── setup_database.py             # Database setup & CSV loader
├── requirements.txt              # Python dependencies
│
├── input/                        # Raw Excel files (not committed)
│   └── NOVEMBER_RECORD.XLSX
│
├── output/                       # Generated CSVs organized by month
│   └── NOVEMBER/
│       ├── clean_NOVEMBER_branch1_daily.csv
│       ├── clean_NOVEMBER_branch1_purchases.csv
│       ├── clean_NOVEMBER_branch1_monthly_summary.csv
│       ├── clean_NOVEMBER_branch2_daily.csv
│       ├── clean_NOVEMBER_branch2_purchases.csv
│       ├── clean_NOVEMBER_branch2_monthly_summary.csv
│       └── clean_NOVEMBER_combined_daily.csv
│
└── darusalam_dbt/
    ├── dbt_project.yml
    └── models/
        ├── staging/
        │   ├── sources.yml
        │   ├── stg_daily_sales.sql
        │   └── stg_monthly_summary.sql
        └── marts/
            ├── schema.yml
            ├── mart_profit_trend.sql
            ├── mart_revenue_breakdown.sql
            ├── mart_expense_ratio.sql
            ├── mart_cash_position.sql
            └── mart_expense_breakdown.sql
```

---

## Database Schema

```
PostgreSQL: darusalam_db
│
├── public schema (raw tables)
│   ├── raw_daily_sales         # 30 rows/month per branch
│   ├── raw_purchases           # Supplier deliveries per branch
│   └── raw_monthly_summary     # 1 row/month per branch (P&L)
│
├── analytics_staging schema (dbt views)
│   ├── stg_daily_sales
│   └── stg_monthly_summary
│
└── analytics_analytics schema (dbt mart tables)
    ├── mart_profit_trend        # KPI 1: Monthly profit by branch
    ├── mart_revenue_breakdown   # KPI 2: Revenue sources breakdown
    ├── mart_expense_ratio       # KPI 3: Expense efficiency
    ├── mart_cash_position       # KPI 4: End of month cash health
    └── mart_expense_breakdown   # KPI 5: Expense categories (unpivoted)
```

---

## Prerequisites

- Python 3.11+
- Docker Desktop
- dbt Core 1.11+
- Git

---

## Setup & Installation

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/darusalam-hospital.git
cd darusalam-hospital
```

### 2. Create Virtual Environment

```bash
python -m venv venv
venv\Scripts\activate        # Windows
source venv/bin/activate     # Mac/Linux
```

### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

### 4. Configure Environment Variables

Create a `.env` file in the project root:

```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=darusalam_db
DB_USER=darusalam_user
DB_PASSWORD=your_password
OUTPUT_DIR=output
```

### 5. Start Docker Containers

```bash
docker-compose up -d
```

This starts:
- PostgreSQL on port `5432`
- Metabase on port `3000`

### 6. Setup Database Tables

```bash
python setup_database.py --setup
```

---

## Monthly Workflow

Run these 4 commands every month when a new Excel file arrives:

```bash
# Step 1 — Clean the Excel file
python darusalam_pipeline.py input/NOVEMBER_RECORD.XLSX

# Step 2 — Load CSVs into PostgreSQL
python setup_database.py --load

# Step 3 — Run dbt transformations
cd darusalam_dbt
dbt run

# Step 4 — Open Metabase dashboard
# Navigate to http://localhost:3000
```

---

## dbt Models

| Model | Type | Description |
|---|---|---|
| `stg_daily_sales` | View | Cleaned daily sales staging |
| `stg_monthly_summary` | View | Cleaned monthly P&L staging |
| `mart_profit_trend` | Table | Monthly profit by branch with margins |
| `mart_revenue_breakdown` | Table | Revenue sources and payment methods |
| `mart_expense_ratio` | Table | Expense efficiency vs revenue |
| `mart_cash_position` | Table | End of month cash health |
| `mart_expense_breakdown` | Table | Unpivoted expense categories for charting |

---

## KPI Dashboard (Metabase)

| Chart | Table | Insight |
|---|---|---|
| Branch Profit Comparison | mart_profit_trend | Which branch is more profitable |
| Profit Margin by Branch | mart_profit_trend | Which branch is more efficient |
| Revenue vs Expense | mart_expense_ratio | Cost control per branch |
| Expense Breakdown | mart_expense_breakdown | Where money is going |

---

## November 2025 Results (Verified)

| Branch | Revenue | Profit | Margin |
|---|---|---|---|
| Darusalam I | KES 2,268,412 | KES 939,496 | 41.42% |
| Darusalam II | KES 1,005,449 | KES 444,848 | 44.24% |

> Darusalam II has a higher profit margin despite lower revenue — indicating more efficient cost management per KES earned.

---

## Key Commands Reference

```bash
# Virtual environment
venv\Scripts\activate
pip install -r requirements.txt

# Docker
docker-compose up -d          # start containers
docker-compose stop           # stop containers (keep data)
docker-compose down           # remove containers (keep data)
docker-compose down -v        # remove containers AND data

# Database
python setup_database.py --setup    # create tables (first time only)
python setup_database.py --load     # load CSVs into PostgreSQL

# dbt
dbt debug                     # test connection
dbt run                       # run all models
dbt run --select model_name   # run specific model
dbt docs generate             # generate documentation
dbt docs serve                # view lineage at localhost:8080
```

---

## Tech Stack

| Tool | Version | Purpose |
|---|---|---|
| Python | 3.11 | Data cleaning & loading |
| PostgreSQL | 15 | Data warehouse |
| dbt Core | 1.11.6 | SQL transformations |
| Metabase | Latest | BI dashboard |
| Docker | Latest | Container orchestration |
| pandas | Latest | DataFrame processing |
| psycopg2 | Latest | PostgreSQL connector |

---

## Roadmap

- [ ] `run_pipeline.bat` — one-click monthly automation for accountant
- [ ] `dim_branch` and `dim_date` dimension tables
- [ ] Load all historical months (6+ months)
- [ ] Deploy to cloud VPS for remote access
- [ ] Apache Airflow orchestration for scheduled runs
- [ ] Pharmacore & Ilara Health API integration
- [ ] AI-powered natural language querying (DeepSeek API)

---

## Notes

- Raw Excel files are excluded from Git (`.gitignore`) to protect sensitive financial data
- The pipeline is **idempotent** — safe to run multiple times, no duplicate data
- CSV outputs are organized by month under `output/MONTH/` for clean file management
- dbt models use `{{ ref() }}` for dependency management ensuring correct execution order
