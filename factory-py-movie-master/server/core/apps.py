from django.apps import AppConfig #type: ignore


class CoreConfig(AppConfig):
    name = 'core'

    def ready(self):
        import core.signals
