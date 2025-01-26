# Load necessary library for reading CSV files
library(readr)

# Load required packages for data manipulation and missing value handling
library(zoo)  # For na.approx()
library(dplyr)  # For data manipulation

# Read Walmart sales data from CSV file
walmart_data <- read_csv("data/lab_data.csv")

# Display the dataset structure in RStudio Viewer
View(walmart_data)

#--------------------------------------------
# Print the dimensions of the dataset (rows and columns)
print(dim(walmart_data))

#--------------------------------------------
# Print the class of the Store column and structure of the dataset
print(class(walmart_data$Store))
print(str(walmart_data))

#--------------------------------------------
# Display the first few rows and summary statistics of the dataset
head(walmart_data)
summary(walmart_data)

#--------------------------------------------
# Convert the Date column to Date format
walmart_data$Date <- as.Date(walmart_data$Date, format = "%d-%m-%Y")
str(walmart_data)

#--------------------------------------------
# Count missing values per column and total missing rows
colSums(is.na(walmart_data))
sum(complete.cases(walmart_data) == FALSE)

#--------------------------------------------
# Compute basic statistics on Weekly Sales
mean(walmart_data$Weekly_Sales)
median(walmart_data$Weekly_Sales)
range(walmart_data$Weekly_Sales)

# Compute statistics ignoring missing values
mean(walmart_data$Weekly_Sales, na.rm = TRUE)
median(walmart_data$Weekly_Sales, na.rm = TRUE)
range(walmart_data$Weekly_Sales, na.rm = TRUE)

#--------------------------------------------
# Aggregate average weekly sales by store
avg_sales <- aggregate(Weekly_Sales ~ Store, data = walmart_data, mean, na.rm = TRUE)

# Create a bar plot of average weekly sales per store
barplot(avg_sales$Weekly_Sales, names.arg = avg_sales$Store,
        xlab = "Store",
        ylab = "Average Weekly Sales",
        main = "Average Weekly Sales per Store",
        col = "blue",
        border = "black",
        ylim = c(0, max(avg_sales$Weekly_Sales) + 1000)
)

# Sort stores by average weekly sales in ascending order
sales <- avg_sales[order(avg_sales$Weekly_Sales), ]
print(sales)

#--------------------------------------------
# Subset data for a specific store
specific_store_number <- 20
specific_store_data <- subset(walmart_data, Store == specific_store_number)

# Replace missing values in Weekly Sales with zero
specific_store_data$Weekly_Sales[is.na(specific_store_data$Weekly_Sales)] <- 0

# Ensure the data is sorted by date
specific_store_data <- specific_store_data[order(specific_store_data$Date), ]

# Create a line plot for the selected store
plot(specific_store_data$Date, specific_store_data$Weekly_Sales,
     col = "blue", pch = 16, xlab = "Date", ylab = "Weekly Sales",
     main = paste("Weekly Sales Trends for Store", specific_store_number))

#-------------------------------------------

# Interpolate missing values in Weekly Sales
walmart_data$Weekly_Sales <- na.approx(walmart_data$Weekly_Sales, na.rm = FALSE)

# Compute total sales per store and sort in descending order
store_sales <- walmart_data %>%
  group_by(Store) %>%
  summarise(Total_Sales = sum(Weekly_Sales, na.rm = TRUE)) %>%
  arrange(desc(Total_Sales))

# Select the top 20 stores with the highest total sales
top_stores <- store_sales$Store[1:20]

# Open an empty plot with proper axis limits
plot(1, type = "n", xlab = "Date", ylab = "Weekly Sales",
     xlim = range(walmart_data$Date, na.rm = TRUE), 
     ylim = range(walmart_data$Weekly_Sales, na.rm = TRUE))

# Assign unique colors for each store
colors <- rainbow(length(top_stores))

# Plot sales trends for each of the top 20 stores
for (i in 1:length(top_stores)) {
  store_data <- walmart_data %>%
    filter(Store == top_stores[i]) %>%
    arrange(Date)  # Ensure dates are in correct order
  
  lines(store_data$Date, store_data$Weekly_Sales, col = colors[i], type = "l")
}

# Add a legend to the plot
legend("topright", legend = paste("Store", top_stores), col = colors, lty = 1)

#-------------------------------------------
# Select the relevant columns
selected_data <- walmart_data[c("Weekly_Sales","Temperature","Fuel_Price","CPI","Unemployment")]
# compute the correlations
cor_matrix <- cor(selected_data,use = "complete.obs")

print(cor_matrix)
pairs(selected_data) #scatterplot matrix