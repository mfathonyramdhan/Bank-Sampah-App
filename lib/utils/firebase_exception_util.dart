String generateAuthMessage(String? exceptionCode) {
  switch (exceptionCode) {
    case "invalid-email":
      return "Gunakan Akun Email Yang Valid";
    case "wrong-password":
      return "Password Yang Anda Masukan Salah";
    case "user-not-found":
      return "Gunakan Email Yang Sudah Anda Daftarkan";
    case "user-disabled":
      return "Akun Anda Telah Dinonaktifkan";
    case "too-many-request":
      return "Terlalu Banyak Request. Coba lagi nanti";
    case "operation-not-allowed":
      return "Operasi Tidak Diizinkan";
    case "email-already-in-use":
      return "Email Sudah Pernah Digunakan";
    default:
      return "Server Internal Sedang Bermasalah";
  }
}
