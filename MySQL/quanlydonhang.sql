create database quanlydonhang;
use quanlydonhang;
create table phieu_xuat (
so_px varchar(10) primary key,
ngay_xuat date
);

create table vat_tu(
ma_vtu varchar(10) primary key,
ten_vtu varchar(45)
);

create table chi_tiet_phieu_xuat(
so_px varchar(10),
ma_vtu varchar(10),
primary key(so_px,ma_vtu),
foreign key (so_px) references phieu_xuat(so_px),
foreign key (ma_vtu) references vat_tu(ma_vtu),
dg_xuat int,
sl_suat float
);

create table nha_cc(
ma_ncc varchar(10) primary key,
ten_ncc varchar(45),
dia_chi varchar(45)
);

create table so_dien_thoai(
id int auto_increment primary key,
so_dien_thoai varchar(10),
ma_ncc varchar(10),
foreign key (ma_ncc) references nha_cc(ma_ncc)
);

create table phieu_nhap(
so_pn int auto_increment primary key,
ngay_nhap date
);

create table chi_tiet_phieu_nhap(
ma_vtu varchar(10),
so_pn int,
gd_nhap float,
sl_nhap int,
primary key (ma_vtu, so_pn),
foreign key (ma_vtu) references vat_tu(ma_vtu),
foreign key (so_pn) references phieu_nhap(so_pn)
);

create table don_dh(
so_hd int auto_increment primary key,
ngay_dh date,
ma_ncc varchar(10),
foreign key (ma_ncc) references nha_cc(ma_ncc)
);

create table chi_tiet_don_dat_hang(
ma_vtu varchar(10),
so_hd int,
primary key(ma_vtu, so_hd),
foreign key (ma_vtu) references vat_tu(ma_vtu),
foreign key (so_hd) references don_dh(so_hd)
);