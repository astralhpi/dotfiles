# ============================================================================
# FILE: tag.py
# AUTHOR: Felipe Morales <hel.sheep at gmail.com>
#         Shougo Matsushita <Shougo.Matsu at gmail.com>
# License: MIT license  {{{
#     Permission is hereby granted, free of charge, to any person obtaining
#     a copy of this software and associated documentation files (the
#     "Software"), to deal in the Software without restriction, including
#     without limitation the rights to use, copy, modify, merge, publish,
#     distribute, sublicense, and/or sell copies of the Software, and to
#     permit persons to whom the Software is furnished to do so, subject to
#     the following conditions:
#
#     The above copyright notice and this permission notice shall be included
#     in all copies or substantial portions of the Software.
#
#     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
#     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
#     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
#     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
#     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# }}}
# ============================================================================

from os.path import getmtime, exists, getsize
from collections import namedtuple
from deoplete.util import parse_file_pattern
from .base import Base

TagsCacheItem = namedtuple('TagsCacheItem', 'mtime candidates')


class Source(Base):

    def __init__(self, vim):
        Base.__init__(self, vim)

        self.name = 'tag'
        self.mark = '[T]'

        self.__cache = {}

    def gather_candidates(self, context):
        candidates = []
        limit = self.vim.vars['deoplete#tag#cache_limit_size']
        include_files = self.vim.call(
            'neoinclude#include#get_tag_files') if self.vim.call(
                'exists', '*neoinclude#include#get_tag_files') else []
        for filename in [x for x in self.vim.call(
                'map', self.vim.call('tagfiles') + include_files,
                'fnamemodify(v:val, ":p")')
                         if exists(x) and getsize(x) < limit]:
            mtime = getmtime(filename)
            if filename not in self.__cache or self.__cache[
                    filename].mtime != mtime:
                with open(filename, 'r', errors='replace') as f:
                    new_candidates = parse_file_pattern(
                        f, '^[a-zA-Z_]\w*(?=\t)')
                    candidates += new_candidates
                    self.__cache[filename] = TagsCacheItem(
                        mtime, new_candidates)
                    limit -= getsize(filename)
            else:
                candidates += self.__cache[filename].candidates
        return [{'word': x} for x in candidates]
