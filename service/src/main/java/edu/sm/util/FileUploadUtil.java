package edu.sm.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class FileUploadUtil {
    public static void deleteFile(String filename, String dir) throws IOException {
        Path filePath = Paths.get(dir + filename);
        Files.deleteIfExists(filePath); // 파일이 존재할 경우만 삭제
    }

    public static void saveFile(MultipartFile mf, String dir) throws IOException {
        String imgName = mf.getOriginalFilename();
        if (imgName == null || imgName.isEmpty()) {
            throw new IllegalArgumentException("사진을 등록해주세요.");
        }

        // 디렉토리 생성
        File directory = new File(dir);
        if (!directory.exists()) {
            boolean isCreated = directory.mkdirs(); // 부모 디렉토리까지 생성
            if (!isCreated) {
                throw new IOException("디렉토리 생성 실패: " + dir);
            }
        }

        // 파일 저장
        byte[] data = mf.getBytes();
        try (FileOutputStream fos = new FileOutputStream(dir + File.separator + imgName)) {
            fos.write(data);
        } catch (IOException e) {
            throw new IOException("파일 저장 실패: " + imgName, e);
        }
    }
}
