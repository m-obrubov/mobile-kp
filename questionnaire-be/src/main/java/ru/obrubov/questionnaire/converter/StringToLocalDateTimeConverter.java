package ru.obrubov.questionnaire.converter;

import org.springframework.boot.context.properties.ConfigurationPropertiesBinding;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
@ConfigurationPropertiesBinding
public class StringToLocalDateTimeConverter implements Converter<String, LocalDateTime> {
    @Override
    public LocalDateTime convert(String stringDateTime) {
        if (stringDateTime.isEmpty() || !stringDateTime.matches("[\\d]{2}-[\\d]{2}-[\\d]{4}")) {
            return null;
        }
        int day = Integer.valueOf(stringDateTime.substring(0, 2));
        int month = Integer.valueOf(stringDateTime.substring(3, 5));
        int year = Integer.valueOf(stringDateTime.substring(6, 10));
        return LocalDateTime.of(year, month, day, 0, 0);
    }
}
