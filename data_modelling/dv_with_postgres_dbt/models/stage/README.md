derived_columns  maps original column names to new column names
ashed_columns defines unique hashed identifiers for various attributes in the raw_inventory data model. In Data Vault, hashed columns are used to create unique, consistent, and irreversible identifiers for data items
SUPPLIER_PK is the primary key for the supplier table

  SUPPLIER_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'SUPPLIERKEY'
      - 'SUPPLIER_ACCTBAL'
      - 'SUPPLIER_ADDRESS'
      - 'SUPPLIER_PHONE'
      - 'SUPPLIER_COMMENT'
      - 'SUPPLIER_NAME'
  supplier hashdiff is a hashdiff column that is used to track changes in the supplier table. It is a hash of the supplier table's primary key and all other columns in the supplier table.



  2. Loading Data with SQL Logic

After defining the YAML metadata, the SQL code initializes variables to use the metadata:
Variables Setup

    The metadata_dict variable converts yaml_metadata to a dictionary.
    source_model, derived_columns, and hashed_columns are extracted from this dictionary for use in SQL.

SQL CTE (WITH staging AS)

    A staging CTE (Common Table Expression) is created, with:
        automate_dv.stage(...) function, which is likely a helper macro that performs:
            Data Transformation: Using source_model, derived_columns, and hashed_columns to structure and transform data from raw_inventory.
            Source Column Inclusion: include_source_columns=true ensures that all original columns from source_model are included.
        This CTE will prepare data by deriving, hashing, and transforming columns as specified in the YAML.

Final Query

    The SELECT statement selects all columns (*) from the staging CTE, and adds two columns:
        LOAD_DATE: Fixed as the current load date.
        EFFECTIVE_FROM: Also set to the LOAD_DATE, marking the record’s effective start date.

This query will prepare the data by transforming and staging it with unique identifiers, derived columns, and change tracking features as defined in the Data Vault methodology.