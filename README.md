# Food Delivery App Data Analysis

Cleaning and analysing Zomato's Bangalore restaurant listings with **Python (pandas)** and **SQL (MySQL)**, to answer business questions a food-delivery company might ask. Completed as part of the HiCounselor data analytics programme.

## Key findings

From 30,336 cleaned listings covering 7,108 distinct restaurants:

- **Online ordering wins engagement.** Restaurants with online ordering have **6.79 million votes**, against **3.91 million** for those without: 63% of all votes.
- **Delivery and dine-out dominate by volume, not by rating.** They're the two biggest categories (13,153 and 10,188 listings) but have the lowest average rating, **3.65**. Buffets (3.96), drinks & nightlife (3.93) and pubs & bars (3.91) rate highest.
- **The most-voted delivery restaurants** are Empire Restaurant (8,286 votes), Church Street Social (7,544) and Meghana Foods (7,233).
- **Price and rating in Indiranagar:** the most expensive restaurant (Sly Granny, ₹2,500 for two) rates **4.4**, and the cheapest (Srinidhi Sagar Food Line, ₹40) rates **3.7**.
- **The single most-voted restaurant** is Byg Brewski Brewing Company (16,832 votes, rated 4.9), best known for its cocktails, butter chicken and craft beer.
- **Expansion targets:** popular, highly rated restaurants that don't take online orders, led by Toit (14,956 votes, 4.7), Truffles (14,726, 4.7) and AB's – Absolute Barbecues (12,121, 4.9). Onboarding them is the clearest growth opportunity.

## How it works

### 1. Cleaning (Python), `Food Delivery App Data Analysis - HiCounselor.ipynb`

Turns the raw scrape (`zomato.csv`, 56,252 rows) into `zomatocleaned.csv` (30,336 rows):

1. Drop columns not needed (address, phone)
2. Rename columns to SQL-friendly names
3. Handle missing values
4. Remove exact duplicates
5. Remove rows where scraped review text spilled into other columns
6. Normalise ratings (`4.1/5` → `4.1`; `NEW` and `-` → `0`) and stray values
7. Remove garbled characters from names, then export

### 2. Analysis (SQL), `Food Delivery App Data Analysis.sql`

Seven questions, each a commented MySQL query on a `zomato` table loaded from the cleaned CSV:

1. Top 5 most-voted restaurants in Delivery
2. Top 5 highest-rated Delivery restaurants in Banashankari
3. Rating of the most expensive vs the cheapest restaurant in Indiranagar
4. Total votes with vs without online ordering
5. Restaurants, votes and average rating by restaurant type
6. The most-liked dishes at the most-voted restaurant
7. Top 15 well-rated, popular restaurants without online ordering

**Things the queries handle:**
- **Repeated restaurants.** The same restaurant appears once per category and area it's listed in, so "top N" queries group by name and list each restaurant once.
- **Costs stored as text.** Prices are text like `1,200`, so they're converted to numbers before sorting. Sorting the text directly would rank ₹950 above ₹2,500.
- **Unrated restaurants.** A rating of `0` means "not rated yet", so it's left out of averages.

## Running it

```bash
pip install -r requirements.txt
jupyter notebook "Food Delivery App Data Analysis - HiCounselor.ipynb"
```

Run all cells to rebuild `zomatocleaned.csv`. Then import it into MySQL as a table called `zomato` (for example with MySQL Workbench's Table Data Import Wizard) and run the SQL file.

## Data

The Zomato Bangalore restaurants dataset, scraped from Zomato's website and published on Kaggle. It's included here for convenience. It reflects listings at the time of the scrape, not today's restaurants or ratings.

## Licence

The code is MIT licensed; see [LICENSE](LICENSE). The dataset keeps its original terms.
