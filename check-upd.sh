#!/bin/bash

# Проверка наличия обновлений для дистрибутивов DEB (Ubuntu/Debian)
if [ -x "$(command -v apt)" ]; then
  echo "Проверка обновлений для дистрибутивов DEB..."
  apt update
  deb_updates=$(apt list --upgradable 2>/dev/null | grep -cE 'upgradable|$')
  if [ "$deb_updates" -gt 0 ]; then
    echo "Доступны обновления для дистрибутивов DEB. Установка..."
    apt upgrade -y
    if [ -f /var/run/reboot-required ]; then
      echo "Требуется перезагрузка системы для дистрибутивов DEB. Выполнение перезагрузки..."
      reboot
    fi
  else
    echo "Для дистрибутивов DEB нет доступных обновлений."
  fi
fi

# Проверка наличия обновлений для дистрибутивов RPM (Red Hat/CentOS/Fedora)
if [ -x "$(command -v yum)" ]; then
  echo "Проверка обновлений для дистрибутивов RPM..."
  yum check-update
  rpm_updates=$(yum list updates -q 2>/dev/null | grep -cE 'updates|$')
  if [ "$rpm_updates" -gt 0 ]; then
    echo "Доступны обновления для дистрибутивов RPM. Установка..."
    yum update -y
    if [ -f /var/run/reboot-required ]; then
      echo "Требуется перезагрузка системы для дистрибутивов RPM. Выполнение перезагрузки..."
      reboot
    fi
  else
    echo "Для дистрибутивов RPM нет доступных обновлений."
  fi
fi

# Проверка наличия обновлений для дистрибутивов DNF (Fedora)
if [ -x "$(command -v dnf)" ]; then
  echo "Проверка обновлений для дистрибутивов DNF..."
  dnf check-update
  dnf_updates=$(dnf list updates -q 2>/dev/null | grep -cE 'updates|$')
  if [ "$dnf_updates" -gt 0 ]; then
    echo "Доступны обновления для дистрибутивов DNF. Установка..."
    dnf upgrade -y
    if [ -f /var/run/reboot-required ]; then
      echo "Требуется перезагрузка системы для дистрибутивов DNF. Выполнение перезагрузки..."
      reboot
    fi
  else
    echo "Для дистрибутивов DNF нет доступных обновлений."
  fi
fi

echo "Проверка обновлений завершена."
