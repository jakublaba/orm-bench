create schema if not exists bench;

-- 1. USERS
create table bench.user (
    id bigint primary key,
    email text not null,
    country text not null,
    created_at timestamptz not null
);

create index id_user_country on bench.user(country);

-- 2. ADDRESSES
create table bench.user_address (
    id bigint primary key,
    user_id bigint not null references bench.user(id),
    city text not null,
    country text not null,
    is_primary boolean not null
);

create index idx_address_user_id on bench.user_address(user_id);

-- 3. PRODUCTS
create table bench.product (
    id bigint primary key,
    name text not null,
    category_id int not null,
    price_pln_gr int not null
);

create index idx_product_category on bench.product(category_id);

-- 4. PRODUCT CATEGORIES
create table bench.product_category (
    id int primary key,
    name text not null
);

-- 5. ORDERS
create table bench.order (
    id bigint primary key,
    user_id bigint not null references bench.user(id),
    created_at timestamptz not null,
    status smallint not null,
    total_pln_gr bigint not null
);

create index idx_order_user_id on bench.order(user_id);
create index idx_order_created_at on bench.order(created_at);

-- 6. ORDER ITEMS
create table bench.order_item (
    id bigint primary key,
    order_id bigint not null references bench.order(id),
    product_id bigint not null references bench.product(id),
    quantity int not null,
    price_pln_gr int not null
);

create index idx_item_order_id on bench.order_item(order_id);
create index idx_item_product_id on bench.order_item(product_id);

-- 7. PAYMENTS
create table bench.payment (
    id bigint primary key,
    order_id bigint not null references bench.order(id),
    amount_pln_gr bigint not null,
    provider text not null,
    status smallint not null,
    created_at timestamptz not null
);

create index idx_payment_order_id on bench.payment(order_id);
