import 'package:cityflat/models/service_model.dart';
import 'package:flutter/material.dart';

class ServiceProvider extends ChangeNotifier {
  List<Service> _services = [];

  List<Service> get services => _services;

  void setServices(List<Service> services) {
    _services = services;
  }

  void addService(Service newService) {
    _services.add(newService);
    notifyListeners();
  }

  void updateService(Service updatedService) {
    int index =
        _services.indexWhere((service) => service.id == updatedService.id);
    if (index != -1) {
      _services[index] = updatedService;
      notifyListeners();
    }
  }

  void deleteService(String deletedServiceId) {
    _services.removeWhere((service) => service.id == deletedServiceId);
    notifyListeners();
  }
}
