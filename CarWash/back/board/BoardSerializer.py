from rest_framework import serializers
from user import UserSerializer
from .models import Board


class BoardSerializer(serializers.ModelSerializer):
    class Meta:
        model = Board
        fields = (
            'id', 'title', 'context', 'image'
        )
        read_only_fields = ('author', 'write_date', 'modify_date')

    # def get_board(self):
    #     return Board
