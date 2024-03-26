import urllib.parse

from django.core.exceptions import ObjectDoesNotExist
from django.core.paginator import Paginator, EmptyPage
from django.http import JsonResponse

from board.models import Board


# Create your views here.
def select_board_list(request, page=None,
                      page_size=None):
    try:
        page = int(page) if page else 1
        page_size = int(page_size) if page_size else 10

        start_index = (page - 1) * page_size
        end_index = start_index + page_size

        total_count = Board.objects.count()
        board_list = Board.objects.all().order_by('-id')[start_index:end_index].values()

        response_data = {
            'response_code': True,
            'total_count': total_count,
            'board_list': list(board_list),
        }

        return JsonResponse(response_data, safe=False)

    except ObjectDoesNotExist:
        response_data = {
            'response_code': False,
            'message': '게시글이 존재하지 않습니다.'
        }

        return JsonResponse(response_data)

    except Exception as e:
        response_data = {
            'response_code': False,
            'message': f'서버 오류: {str(e)}'
        }
        return JsonResponse(response_data)


def board_info(request, page=None, items_per_page=None, category=None):
    page = int(request.GET.get("page", 1))
    items_per_page = int(request.GET.get("itemsPerPage", 10))
    category = str(request.GET.get("category"))

    if category == 'work':
        board_items = Board.objects.filter(category='작업').order_by('-write_date')
    elif category == 'notice':
        board_items = Board.objects.filter(category='공지').order_by('-write_date')
    else:
        board_items = Board.objects.all().order_by('-write_date')

    # board_items = Board.objects.order_by('-write_date')
    paginator = Paginator(board_items, items_per_page)
    total_items = paginator.count

    try:
        current_page = paginator.page(page)
    except EmptyPage:
        current_page = paginator.page(paginator.num_pages)

    board_list = []
    for item in current_page:
        image_url = urllib.parse.unquote(item.image.url).replace("/https:/", "https://") if item.image else None
        board_list.append({
            "id": item.id,
            "title": item.title,
            "image": image_url,
            "write_date": item.write_date.strftime("%Y-%m-%d %H:%M:%S"),
        })

    response_data = {
        "response_code": "success",
        "board_list": board_list,
        "totalItems": total_items,
    }
    return JsonResponse(response_data)


def board_detail(request, board_id):
    try:
        board = Board.objects.get(pk=board_id)
        image_url = urllib.parse.unquote(board.image.url).replace("/https:/", "https://") if board.image else None

        response_data = {
            "response_code": "success",
            "id": board.id,
            "title": board.title,
            "context": board.context,
            "image": image_url,
            "write_date": board.write_date.strftime("%Y-%m-%d %H:%M:%S"),
        }
        return JsonResponse(response_data)

    except ObjectDoesNotExist:
        response_data = {
            "response_code": "error",
            "message": "게시글이 존재하지 않습니다.",
        }
        return JsonResponse(response_data)
