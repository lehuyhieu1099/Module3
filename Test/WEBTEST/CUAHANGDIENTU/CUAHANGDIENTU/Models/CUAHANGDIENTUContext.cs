using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace CUAHANGDIENTU.Models
{
    public partial class CUAHANGDIENTUContext : DbContext
    {
        public CUAHANGDIENTUContext()
        {
        }

        public CUAHANGDIENTUContext(DbContextOptions<CUAHANGDIENTUContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Chungtu> Chungtus { get; set; }
        public virtual DbSet<Mathang> Mathangs { get; set; }
        public virtual DbSet<Phieuthutien> Phieuthutiens { get; set; }
        public virtual DbSet<VwChungTu> VwChungTus { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
//#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=.\\SQLExpress;Database=CUAHANGDIENTU;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Chungtu>(entity =>
            {
                entity.HasKey(x => x.Sochungtu);

                entity.ToTable("CHUNGTU");

                entity.Property(e => e.Sochungtu).HasColumnName("SOCHUNGTU");

                entity.Property(e => e.Diachikhachhang)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("DIACHIKHACHHANG");

                entity.Property(e => e.Dongia)
                    .HasColumnType("money")
                    .HasColumnName("DONGIA")
                    .HasAnnotation("Relational:ColumnType", "money");

                entity.Property(e => e.Mahang).HasColumnName("MAHANG");

                entity.Property(e => e.Ngaylap)
                    .HasColumnType("date")
                    .HasColumnName("NGAYLAP")
                    .HasAnnotation("Relational:ColumnType", "date");

                entity.Property(e => e.Soluong).HasColumnName("SOLUONG");

                entity.Property(e => e.Tenkhachhang)
                    .IsRequired()
                    .HasMaxLength(50)
                    .HasColumnName("TENKHACHHANG");

                entity.HasOne(d => d.MahangNavigation)
                    .WithMany(p => p.Chungtus)
                    .HasForeignKey(x => x.Mahang)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CHUNGTU_MATHANG");
            });

            modelBuilder.Entity<Mathang>(entity =>
            {
                entity.HasKey(x => x.Mahang);

                entity.ToTable("MATHANG");

                entity.Property(e => e.Mahang).HasColumnName("MAHANG");

                entity.Property(e => e.Chitietmathang)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("CHITIETMATHANG");

                entity.Property(e => e.Giaban)
                    .HasColumnType("money")
                    .HasColumnName("GIABAN")
                    .HasAnnotation("Relational:ColumnType", "money");

                entity.Property(e => e.Soluong).HasColumnName("SOLUONG");

                entity.Property(e => e.Tenhang)
                    .IsRequired()
                    .HasMaxLength(50)
                    .HasColumnName("TENHANG");
            });

            modelBuilder.Entity<Phieuthutien>(entity =>
            {
                entity.HasKey(x => x.Sophieu);

                entity.ToTable("PHIEUTHUTIEN");

                entity.Property(e => e.Sophieu).HasColumnName("SOPHIEU");

                entity.Property(e => e.Ngaythutien)
                    .HasColumnType("date")
                    .HasColumnName("NGAYTHUTIEN")
                    .HasAnnotation("Relational:ColumnType", "date");

                entity.Property(e => e.Sochungtu).HasColumnName("SOCHUNGTU");

                entity.Property(e => e.Sotien)
                    .HasColumnType("money")
                    .HasColumnName("SOTIEN")
                    .HasAnnotation("Relational:ColumnType", "money");

                entity.HasOne(d => d.SochungtuNavigation)
                    .WithMany(p => p.Phieuthutiens)
                    .HasForeignKey(x => x.Sochungtu)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PHIEUTHUTIEN_CHUNGTU");
            });

            modelBuilder.Entity<VwChungTu>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("vw_ChungTu");

                entity.Property(e => e.Diachikhachhang)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("DIACHIKHACHHANG");

                entity.Property(e => e.Dongia)
                    .HasColumnType("money")
                    .HasColumnName("DONGIA")
                    .HasAnnotation("Relational:ColumnType", "money");

                entity.Property(e => e.Mahang).HasColumnName("MAHANG");

                entity.Property(e => e.Ngaylap)
                    .HasColumnType("date")
                    .HasColumnName("NGAYLAP")
                    .HasAnnotation("Relational:ColumnType", "date");

                entity.Property(e => e.Sochungtu)
                    .ValueGeneratedOnAdd()
                    .HasColumnName("SOCHUNGTU");

                entity.Property(e => e.Soluong).HasColumnName("SOLUONG");

                entity.Property(e => e.Tenkhachhang)
                    .IsRequired()
                    .HasMaxLength(50)
                    .HasColumnName("TENKHACHHANG");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
